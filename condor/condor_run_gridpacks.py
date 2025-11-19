#!/usr/bin/env python3
import os
import argparse
import getpass
from pathlib import Path

EXEC_NAME = "batchexec"
LOGS_NAME = "batchlogs"
DEFAULT_TAG = "Run2023"

USER = getpass.getuser()
nobackup = f'/uscms_data/d1/{USER}'
WORK_DIR = os.getcwd()
EOS_STORE_REL = f"/store/user/{USER}/HSCP/gridpack_output/root_files"
EOS_ROOT_URL  = f"root://cmseos.fnal.gov//{EOS_STORE_REL}"

class ArgumentParser(argparse.ArgumentParser):
    def __init__(self):
        super().__init__(usage="%(prog)s [options]")
        self.add_argument("--tag", type=str, default=DEFAULT_TAG)
        self.add_argument("--xqcut", type=int, required=True, help="XQCUT/QCUT (must match the tarball).")
        self.add_argument("-o", "--out", required=True, help="(Unused for EOS mode) Output dir for ROOT files")
        self.add_argument("-i", "--fragment", dest="fragment", required=False, help="Fragment file")
        self.add_argument("--in", dest="fragment", required=False, help="Fragment file (alias of --fragment)")
        self.add_argument("-q", "--queue", type=str, default="tomorrow")
        self.add_argument("-j", "--jobs", type=int, default=1)
        self.add_argument("-n", "--nevents", type=int, default=20000)
        self.add_argument("-r", "--run", type=str, required=True, help="Run/process name")
        self.add_argument("--cmssw", type=str, default="CMSSW_10_6_47", help="CMSSW version (default: %(default)s)")

def create_submit_file(run, cards, tag, jobs, queue, exec_file, logs_dir, xqcut):
    if not exec_file:
        raise ValueError("exec_file is None/empty; cannot write submit.sub")
    if not os.path.isfile(exec_file):
        raise FileNotFoundError(f"Executable file does not exist: {exec_file}")

    exec_file = os.path.abspath(exec_file)
    cards_abs = os.path.abspath(cards)

    xqcut_tag = f"xqcut{xqcut}"
    submit_file = f'condor_submit_{run}_{xqcut_tag}.sub' 
    with open(submit_file, 'w') as fi:
        fi.write(f"""executable              = {exec_file}
arguments               = $(ClusterId)$(ProcId)
transfer_input_files    = {cards_abs}
should_transfer_files   = YES
when_to_transfer_output = ON_EXIT
output                  = {logs_dir}/{run}_{xqcut_tag}_$(ClusterId).$(ProcId).out
error                   = {logs_dir}/{run}_{xqcut_tag}_$(ClusterId).$(ProcId).err
log                     = {logs_dir}/{run}_{xqcut_tag}.log
request_cpus            = {jobs}
+JobFlavour             = "{queue}"
+ApptainerImage         = "/cvmfs/singularity.opensciencegrid.org/cmssw/cms:rhel7"
request_memory          = 8000

queue 1
""")
    return submit_file

def create_exec_file(run, fragment_path, exec_dir, out_dir, tag, nevents, xqcut, cmssw_version):
    xqcut_tag = f"xqcut{xqcut}" if xqcut is not None else "xqcutNA"
    exec_file = Path(exec_dir) / f'job_{run}_{xqcut_tag}.sh'
    frag_name = Path(fragment_path).name

    with open(exec_file, 'w') as fi:
        fi.write(f"""#!/bin/bash
set -eo pipefail
source /cvmfs/cms.cern.ch/cmsset_default.sh

# Networking: some slots prefer IPv4 for XRootD
export XRD_NETWORKSTACK=IPv4

RUN="{run}"
TAG="{tag}"
NEVENTS="{nevents}"
XQCUT="{xqcut}"
FRAGMENT="{frag_name}"
OUTDIR="{out_dir}"
WORKAREA="$PWD"
CMSSW_VERSION="{cmssw_version}"
EOS_ROOT_URL="{EOS_ROOT_URL}"
EOS_STORE_REL="{EOS_STORE_REL}"

echo "[job] RUN=$RUN"
echo "[job] TAG=$TAG"
echo "[job] NEVENTS=$NEVENTS"
echo "[job] XQCUT=$XQCUT"
echo "[job] Using fragment (basename): $FRAGMENT"
echo "[job] CMSSW: $CMSSW_VERSION"
echo "[job] Work area (Condor execute dir): $WORKAREA"

if [[ "$CMSSW_VERSION" == CMSSW_10_6_* ]]; then
  export SCRAM_ARCH="slc7_amd64_gcc700"
  echo "[job] SCRAM: $SCRAM_ARCH"
else
  echo "[warning] CMSSW=$CMSSW_VERSION, using existing SCRAM_ARCH=$SCRAM_ARCH (adjust if needed)."
fi

# The fragment is transferred by HTCondor into $WORKAREA (execute dir).
if [[ ! -f "$WORKAREA/$FRAGMENT" ]]; then
  echo "[fatal] Fragment not found at $WORKAREA/$FRAGMENT"
  echo "[debug] Listing $WORKAREA contents:"
  ls -al "$WORKAREA" || true
  exit 10
fi

echo "[1/6] building area"
echo "Found fragment at $WORKAREA/$FRAGMENT"
echo "[preview] --- head of fragment ---"
head -n 20 "$WORKAREA/$FRAGMENT" || true
echo "[preview] ------------------------"

echo "[CMSSW Env]"
scramv1 project CMSSW $CMSSW_VERSION
cd $CMSSW_VERSION/src/
eval `scramv1 runtime -sh`

echo "[Copying fragment into CMSSW area]"
mkdir -p "$CMSSW_BASE/src/Configuration/GenProduction/python"
cp -v "$WORKAREA/$FRAGMENT" "$CMSSW_BASE/src/Configuration/GenProduction/python/"
ls "$CMSSW_BASE/src/Configuration/GenProduction/python/" || true

echo "[2/6] cmsenv & build"
cd "$CMSSW_BASE/src"
cmsenv
scram b -j8

# Make sure we have writable local copies of BOTH runner scripts (avoid /cvmfs noexec)
mkdir -p "$CMSSW_BASE/src/GeneratorInterface/LHEInterface/data"
for s in run_generic_tarball_xrootd.sh run_generic_tarball_cvmfs.sh; do
  cp -f "$CMSSW_RELEASE_BASE/src/GeneratorInterface/LHEInterface/data/$s" \\
        "$CMSSW_BASE/src/GeneratorInterface/LHEInterface/data/$s"
  chmod +x "$CMSSW_BASE/src/GeneratorInterface/LHEInterface/data/$s"
done

echo "[3/6] LHE & GEN only (cfg)"
cmsDriver.py Configuration/GenProduction/python/$FRAGMENT \\
  --python_filename $RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-GEN-ONLY_cfg.py \\
  --eventcontent RAWSIM,LHE \\
  --step           LHE,GEN \\
  --datatier       GEN,LHE \\
  --fileout file:$RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-GEN-ONLY.root \\
  --conditions   106X_upgrade2018_realistic_v4 \\
  --beamspot     Realistic25ns13TeVEarly2018Collision \\
  --geometry     DB:Extended \\
  --era          Run2_2018 \\
  --mc -n $NEVENTS \\
  --customise Configuration/DataProcessing/Utils.addMonitoring \\
  --no_exec

# (Optional) sanity: confirm remote gridpack presence
xrdfs root://cmseos.fnal.gov stat /store/user/{USER}/HSCP/gridpack_output/tarballs/RunII/ms-Rhadron_mstop_2000_slc7_amd64_gcc700_CMSSW_10_6_47_xqcut60_tarball.tar.xz || true

echo "[4/6] cmsRun"
cmsRun $RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-GEN-ONLY_cfg.py

# === Collect ONLY the two EDM outputs back to the job sandbox (/srv) ===
BASE="$RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-GEN-ONLY"
OUT_GEN="$CMSSW_BASE/src/$BASE.root"
OUT_LHEEDM="$CMSSW_BASE/src/${{BASE}}_inLHE.root"

echo "[5/6] collect"
echo "[collect] Looking for outputs:"
ls -lh "$OUT_GEN" "$OUT_LHEEDM" 2>/dev/null || true

cd "$WORKAREA"
mkdir -p "$WORKAREA"

[[ -f "$OUT_GEN"    ]] && cp -v "$OUT_GEN"    "$WORKAREA/" || echo "[warn] Missing: $OUT_GEN"
[[ -f "$OUT_LHEEDM" ]] && cp -v "$OUT_LHEEDM" "$WORKAREA/" || echo "[warn] Missing: $OUT_LHEEDM"

echo "[collect] In sandbox now:"
ls -lh "$WORKAREA" || true

# === Push to EOS ===
echo "[6/6] xrdcp to EOS -> {EOS_STORE_REL}"
# ensure directories (best-effort)
xrdfs cmseos.fnal.gov mkdir /store/user/{USER}/HSCP || true
xrdfs cmseos.fnal.gov mkdir /store/user/{USER}/HSCP/GEN || true

if [[ -f "$WORKAREA/$BASE.root" ]]; then
  xrdcp -f "$WORKAREA/$BASE.root"   "$EOS_ROOT_URL$BASE.root"
else
  echo "[warn] Not found in sandbox: $WORKAREA/$BASE.root"
fi

if [[ -f "$WORKAREA/${{BASE}}_inLHE.root" ]]; then
  xrdcp -f "$WORKAREA/${{BASE}}_inLHE.root" "$EOS_ROOT_URL${{BASE}}_inLHE.root"
else
  echo "[warn] Not found in sandbox: $WORKAREA/${{BASE}}_inLHE.root"
fi

echo "[Run] Completed successfully."
""")
    return str(exec_file)

def main():
    ap = ArgumentParser()
    args = ap.parse_args()

    if not args.fragment:
        ap.error("You must provide a fragment file via -i/--fragment (or --in).")
    if not os.path.isfile(args.fragment):
        ap.error(f"Fragment file does not exist: {args.fragment}")

    # ensure dirs
    exec_dir = Path(EXEC_NAME)
    logs_dir = Path(LOGS_NAME)
    out_dir  = Path(args.out)
    exec_dir.mkdir(exist_ok=True)
    logs_dir.mkdir(exist_ok=True)
    out_dir.mkdir(parents=True, exist_ok=True)

    # create exec
    exec_file = create_exec_file(
        run=args.run,
        fragment_path=args.fragment,
        exec_dir=exec_dir,
        out_dir=str(out_dir), 
        tag=args.tag,
        nevents=args.nevents,
        xqcut=args.xqcut,
        cmssw_version=args.cmssw,
    )

    # validate + make executable + absolutize
    if not exec_file:
        raise RuntimeError("Internal error: create_exec_file returned None")
    exec_abs = os.path.abspath(exec_file)
    os.chmod(exec_abs, 0o755)
    if not os.path.isfile(exec_abs):
        raise FileNotFoundError(f"Executable not found at {exec_abs}")

    # submit file (transfer the fragment so the exec has it)
    submit_file = create_submit_file(
        run=args.run,
        cards=args.fragment,
        tag=args.tag,
        jobs=args.jobs,
        queue=args.queue,
        exec_file=exec_abs,
        logs_dir=str(logs_dir),
        xqcut=args.xqcut,
    )

    print(f"[ok] Wrote exec:   {exec_abs}")
    print(f"[ok] Wrote submit: {submit_file}")
    # Sanity print the executable line from the submit file
    with open(submit_file) as fh:
        for line in fh:
            if line.strip().startswith("executable"):
                print("[debug]", line.strip())
                break

if __name__ == "__main__":
    main()
