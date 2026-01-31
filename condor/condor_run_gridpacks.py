
"""
Condor submission helper for a CMSSW MC chain:

  1) GEN-SIM (LHE,GEN,SIM)  -> GEN-SIM 
  2) DIGI (+ optional Premix) -> GEN-SIM-RAW
  3) HLT -> GEN-SIM-RAW-HLT
  4) RECO -> AODSIM
  5) optional + MiniAOD
  6) optional + NanoAOD

This script writes:
  - an executable bash script into ./batchexec/
  - a condor submit file into the current directory
  - logs into ./batchlogs/

Then you run:
  condor_submit <submit_file>
"""
import os
import argparse
import getpass
from pathlib import Path

EXEC_NAME = "batchexec"
LOGS_NAME = "batchlogs"

DEFAULT_NEVENTS = 5000
DEFAULT_CMSSW = "CMSSW_14_0_22"
DEFAULT_ERA = "Run3_2024"
DEFAULT_CONDITIONS = "140X_mcRun3_2024_realistic_v26"
DEFAULT_HLT_MENU = "2024v14"
DEFAULT_BEAMSPOT = "DBrealistic"

DEFAULT_DO_PREMIX = True
DEFAULT_DO_MINIAOD = True
DEFAULT_DO_NANOAOD = True
DEFAULT_THREADS = 2
DEFAULT_PILEUP_INPUT = (
    "dbs:/Neutrino_E-10_gun/RunIIISummer24PrePremix-Premixlib2024_140X_mcRun3_2024_realistic_v26-v1/PREMIX"
)

DEFAULT_DESIRED_OS = "rhel8"
DEFAULT_SINGULARITY_IMAGE = "/cvmfs/singularity.opensciencegrid.org/cmssw/cms:rhel8"

USER = getpass.getuser()

EOS_ROOTFILES_REL = f"/store/user/{USER}/HSCP/gridpack_output/root_files/"
EOS_ROOTFILES_URL = f"root://cmseos.fnal.gov//{EOS_ROOTFILES_REL}"

EOS_CFGS_REL = f"/store/user/{USER}/HSCP/gridpack_output/cfgs/"
EOS_CFGS_URL = f"root://cmseos.fnal.gov//{EOS_CFGS_REL}"


def choose_scram_arch(cmssw_version: str) -> str:
    """
    Choose a SCRAM_ARCH based on CMSSW version.

    Notes:
      - CMSSW_10_6_* is slc7.
      - Newer releases in your workflow have been EL8 gcc12.
    """
    if cmssw_version.startswith("CMSSW_10_6_"):
        return "slc7_amd64_gcc700"
    try:
        major = int(cmssw_version.split("_")[1])
    except Exception:
        major = 15
    if major >= 14:
        return "el8_amd64_gcc12"
    return "el8_amd64_gcc12"


class ArgumentParser(argparse.ArgumentParser):
    def __init__(self):
        super().__init__(usage="%(prog)s [options]")

        self.add_argument("--tag", type=str, default=DEFAULT_ERA,
                          help="Tag used in output filenames (default: %(default)s)")
        self.add_argument("--xqcut", type=int, required=True,
                          help="XQCUT/QCUT (must match the tarball).")

        self.add_argument("-o", "--out", required=True,
                          help="(Unused for EOS mode) Output dir for ROOT files (kept for compatibility).")
        self.add_argument("-i", "--fragment", dest="fragment", required=False,
                          help="Fragment file")
        self.add_argument("--in", dest="fragment", required=False,
                          help="Fragment file (alias of --fragment)")

        self.add_argument("-q", "--queue", type=str, default="tomorrow",
                          help="Condor JobFlavour (default: %(default)s)")
        self.add_argument("--njobs", type=int, default=1,
                          help="Number of independent Condor jobs to queue (each job runs --nevents events).")
        self.add_argument("-n", "--nevents", type=int, default=DEFAULT_NEVENTS,
                          help="Events per job (default: %(default)s)")
        self.add_argument("--threads", type=int, default=DEFAULT_THREADS,
                          help="Threads per job passed to cmsDriver --nThreads (default: %(default)s).")

        self.add_argument("-r", "--run", type=str, required=True,
                          help="Run/process name")
        self.add_argument("--cmssw", type=str, default=DEFAULT_CMSSW,
                          help="CMSSW version (default: %(default)s)")

        self.add_argument("--hlt-menu", type=str, default=DEFAULT_HLT_MENU,
                          help="HLT menu name for cmsDriver syntax HLT:<menu> (default: %(default)s).")

        self.add_argument("--desired-os", type=str, default=DEFAULT_DESIRED_OS,
                          help='Condor +DesiredOS (default: %(default)s).')
        self.add_argument("--singularity-image", type=str, default=DEFAULT_SINGULARITY_IMAGE,
                          help="Container image path (default: %(default)s)")

        # Premix toggle + pileup input
        premixGroup = self.add_mutually_exclusive_group()
        premixGroup.add_argument("--do-premix", dest="do_premix", action="store_true",
                                 help="Enable pileup (DIGI,DATAMIX,L1,DIGI2RAW) after GEN-SIM (default)")
        premixGroup.add_argument("--no-premix", dest="do_premix", action="store_false",
                                 help="Disable pileup; use standard DIGI,L1,DIGI2RAW")
        self.add_argument("--pileup-input", type=str, default=DEFAULT_PILEUP_INPUT,
                          help=("Pileup source for premix. Either 'dbs:/.../PREMIX' or a local text file "
                                "(one filename per line). Required if --do-premix."))
        self.set_defaults(do_premix=DEFAULT_DO_PREMIX)

        # MiniAOD toggle
        miniGroup = self.add_mutually_exclusive_group()
        miniGroup.add_argument("--do-miniaod", dest="do_miniaod", action="store_true",
                               help="Enable MiniAOD (PAT) step (default)")
        miniGroup.add_argument("--no-miniaod", dest="do_miniaod", action="store_false",
                               help="Disable MiniAOD step")
        self.set_defaults(do_miniaod=DEFAULT_DO_MINIAOD)

        # NanoAOD toggle
        nanoGroup = self.add_mutually_exclusive_group()
        nanoGroup.add_argument("--do-nanoaod", dest="do_nanoaod", action="store_true",
                               help="Enable NanoAOD step (default)")
        nanoGroup.add_argument("--no-nanoaod", dest="do_nanoaod", action="store_false",
                               help="Disable NanoAOD step")
        self.set_defaults(do_nanoaod=DEFAULT_DO_NANOAOD)

        # Conditions / era / beamspot
        self.add_argument("--conditions", type=str, default=DEFAULT_CONDITIONS,
                          help="GlobalTag/conditions (default: %(default)s).")
        self.add_argument("--era", type=str, default=DEFAULT_ERA,
                          help="cmsDriver era (default: %(default)s)")
        self.add_argument("--beamspot", type=str, default=DEFAULT_BEAMSPOT,
                          help="Beamspot name for cmsDriver --beamspot in GEN step (default: %(default)s)")


def create_submit_file(*, run, transfer_inputs, njobs, queue, exec_file, logs_dir,
                       request_cpus: int, desired_os: str, singularity_image: str):
    if not exec_file:
        raise ValueError("exec_file is None/empty; cannot write submit.sub")
    if not os.path.isfile(exec_file):
        raise FileNotFoundError(f"Executable file does not exist: {exec_file}")

    exec_file = os.path.abspath(exec_file)
    transfer_inputs_abs = [os.path.abspath(p) for p in transfer_inputs]
    transfer_inputs_str = ",".join(transfer_inputs_abs)

    base_name = f"{run}_runGridpack"
    submit_file = f"condor_submit_{base_name}.sub"

    with open(submit_file, "w") as fi:
        fi.write(
            f"""executable              = {exec_file}
arguments               = $(ClusterId) $(ProcId)
transfer_input_files    = {transfer_inputs_str}
should_transfer_files   = YES
when_to_transfer_output = ON_EXIT
output                  = {logs_dir}/{base_name}_$(ClusterId).$(ProcId).out
error                   = {logs_dir}/{base_name}_$(ClusterId).$(ProcId).err
log                     = {logs_dir}/{base_name}.log

request_cpus            = {int(request_cpus)}
request_memory          = 8000

+JobFlavour             = "{queue}"
+DesiredOS              = "{desired_os}"
+SingularityImage       = "{singularity_image}"

queue {int(njobs)}
"""
        )
    return submit_file


def create_exec_file(*, run, fragment_path, exec_dir, tag, nevents, xqcut, cmssw_version,
                     do_premix, pileup_input, do_hlt, hlt_menu,
                     do_miniaod, do_nanoaod, conditions, era, beamspot, threads: int):
    base_name = f"{run}_runGridpack"
    exec_file = Path(exec_dir) / f"{base_name}.sh"

    frag_name = Path(fragment_path).name
    scram_arch = choose_scram_arch(cmssw_version)

    with open(exec_file, "w") as fi:
        fi.write(
            f"""#!/bin/bash
set -euo pipefail

CLUSTER_ID="${{1:-0}}"
PROC_ID="${{2:-0}}"
JOBID="${{CLUSTER_ID}}.${{PROC_ID}}"

export SCRAM_ARCH="{scram_arch}"
set +u
source /cvmfs/cms.cern.ch/cmsset_default.sh
set -u

# -----------------------------------------------------------------------------
# Job parameters
# -----------------------------------------------------------------------------
RUN="{run}"
TAG="{tag}"
NEVENTS="{nevents}"
XQCUT="{xqcut}"
FRAGMENT="{frag_name}"

CMSSW_VERSION="{cmssw_version}"
ERA="{era}"
CONDITIONS="{conditions}"
HLT_MENU="{hlt_menu}"
BEAMSPOT="{beamspot}"

DO_PREMIX="{1 if do_premix else 0}"
PILEUP_INPUT_RAW="{pileup_input}"

DO_HLT="{1 if do_hlt else 0}"

DO_MINIAOD="{1 if do_miniaod else 0}"
DO_NANOAOD="{1 if do_nanoaod else 0}"

# -----------------------------------------------------------------------------
# Threads + seed spacing
# -----------------------------------------------------------------------------
NTHREADS="{int(threads)}"
if [[ "$NTHREADS" -lt 1 ]]; then NTHREADS=1; fi
RSEED=$(( (PROC_ID+1) * NTHREADS * 4 + 1001 ))

echo "[job] JOBID=$JOBID RUN=$RUN TAG=$TAG NEVENTS=$NEVENTS XQCUT=$XQCUT"
echo "[job] CMSSW_VERSION=$CMSSW_VERSION SCRAM_ARCH=$SCRAM_ARCH ERA=$ERA CONDITIONS=$CONDITIONS"
echo "[job] DO_PREMIX=$DO_PREMIX PILEUP_INPUT_RAW=$PILEUP_INPUT_RAW"
echo "[job] DO_HLT=$DO_HLT (HLT_MENU=$HLT_MENU) DO_MINIAOD=$DO_MINIAOD DO_NANOAOD=$DO_NANOAOD"
echo "[job] NTHREADS=$NTHREADS RSEED=$RSEED"

if [[ ! -f "$FRAGMENT" ]]; then
  echo "[fatal] Fragment not found in job sandbox: $FRAGMENT"
  echo "[debug] ls -al:"
  ls -al
  exit 10
fi

run_cfg() {{
  local cfg="$1"
  local out="$2"
  echo "[run] cmsRun $cfg"
  cmsRun "$cfg"
  if [[ ! -f "$out" ]]; then
    echo "[fatal] expected output not found: $out"
    exit 2
  fi
}}

# --- Setup CMSSW ---
TOPDIR="$PWD"
if [[ -r "${{CMSSW_VERSION}}/src" ]]; then
  echo "[env] Using existing $CMSSW_VERSION"
else
  echo "[env] Creating $CMSSW_VERSION"
  scram project CMSSW "$CMSSW_VERSION"
fi

cd "$CMSSW_VERSION/src"
eval "$(scram runtime -sh)"

mkdir -p "$CMSSW_BASE/src/Configuration/GenProduction/python"
cp -v "$TOPDIR/$FRAGMENT" "$CMSSW_BASE/src/Configuration/GenProduction/python/fragment.py"

scram b -j8
cd "$TOPDIR"

# =========================================
# PASS 1: GEN-SIM (LHE,GEN,SIM)
# =========================================
BASE_GENSIM="$RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-job$JOBID-GEN-SIM"

cmsDriver.py Configuration/GenProduction/python/fragment.py \\
  --python_filename "${{BASE_GENSIM}}_cfg.py" \\
  --eventcontent RAWSIM,LHE \\
  --step LHE,GEN,SIM \\
  --datatier GEN-SIM,LHE \\
  --fileout "file:${{BASE_GENSIM}}.root" \\
  --conditions "$CONDITIONS" \\
  --beamspot "$BEAMSPOT" \\
  --geometry DB:Extended \\
  --era "$ERA" \\
  --mc -n "$NEVENTS" \\
  --nThreads "$NTHREADS" \\
  --customise SimG4Core/CustomPhysics/Exotica_HSCP_SIM_cfi.customise \\
  --customise SimG4Core/CustomPhysics/GenPlusSimParticles_cfi.customizeKeep \\
  --customise SimG4Core/CustomPhysics/GenPlusSimParticles_cfi.customizeProduce \\
  --customise Configuration/DataProcessing/Utils.addMonitoring \\
  --customise_commands "process.RandomNumberGeneratorService.externalLHEProducer.initialSeed=${{RSEED}}; process.source.numberEventsInLuminosityBlock=cms.untracked.uint32(143)" \\
  --no_exec
run_cfg "${{BASE_GENSIM}}_cfg.py" "${{BASE_GENSIM}}.root"

# =========================================
# PASS 2: DIGI (Premix or Standard) -> GEN-SIM-RAW
# =========================================
BASE_DIGIRAW="$RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-job$JOBID-GEN-SIM-RAW"

if [[ "$DO_PREMIX" == "1" ]]; then
  if [[ -z "$PILEUP_INPUT_RAW" ]]; then
    echo "[fatal] DO_PREMIX=1 but --pileup-input was not provided."
    exit 30
  fi

  if [[ "$PILEUP_INPUT_RAW" == dbs:* ]]; then
    PILEUP_INPUT="$PILEUP_INPUT_RAW"
  else
    PILEUP_LOCAL="$(basename "$PILEUP_INPUT_RAW")"
    if [[ ! -f "$PILEUP_LOCAL" ]]; then
      echo "[fatal] local pileup list not found in sandbox: $PILEUP_LOCAL"
      echo "[debug] ls -al:"
      ls -al
      exit 31
    fi
    PILEUP_INPUT="filelist:$PILEUP_LOCAL"
  fi

  echo "[premix] pileup_input=$PILEUP_INPUT"

  cmsDriver.py stepDIGIPremix \\
    --python_filename "${{BASE_DIGIRAW}}_cfg.py" \\
    --eventcontent PREMIXRAW \\
    --datatier GEN-SIM-RAW \\
    --filein  "file:${{BASE_GENSIM}}.root" \\
    --fileout "file:${{BASE_DIGIRAW}}.root" \\
    --pileup_input "$PILEUP_INPUT" \\
    --step DIGI,DATAMIX,L1,DIGI2RAW \\
    --procModifiers premix_stage2 \\
    --datamix PreMix \\
    --conditions "$CONDITIONS" \\
    --geometry DB:Extended \\
    --era "$ERA" \\
    --mc -n "$NEVENTS" \\
    --nThreads "$NTHREADS" \\
    --customise Configuration/DataProcessing/Utils.addMonitoring \\
    --no_exec

  run_cfg "${{BASE_DIGIRAW}}_cfg.py" "${{BASE_DIGIRAW}}.root"

else
  cmsDriver.py stepDIGIRAW \\
    --python_filename "${{BASE_DIGIRAW}}_cfg.py" \\
    --eventcontent RAWSIM \\
    --datatier GEN-SIM-RAW \\
    --step DIGI,L1,DIGI2RAW \\
    --filein  "file:${{BASE_GENSIM}}.root" \\
    --fileout "file:${{BASE_DIGIRAW}}.root" \\
    --conditions "$CONDITIONS" \\
    --geometry DB:Extended \\
    --era "$ERA" \\
    --mc -n "$NEVENTS" \\
    --nThreads "$NTHREADS" \\
    --customise Configuration/DataProcessing/Utils.addMonitoring \\
    --no_exec

  run_cfg "${{BASE_DIGIRAW}}_cfg.py" "${{BASE_DIGIRAW}}.root"
fi

# =========================================
# PASS 3: HLT -> GEN-SIM-RAW-HLT
# =========================================
BASE_HLT="$RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-job$JOBID-GEN-SIM-RAW-HLT"

cmsDriver.py stepHLT \\
  --python_filename "${{BASE_HLT}}_cfg.py" \\
  --eventcontent RAWSIM \\
  --datatier GEN-SIM-RAW \\
  --step HLT:${{HLT_MENU}} \\
  --filein  "file:${{BASE_DIGIRAW}}.root" \\
  --fileout "file:${{BASE_HLT}}.root" \\
  --conditions "$CONDITIONS" \\
  --geometry DB:Extended \\
  --era "$ERA" \\
  --mc -n "$NEVENTS" \\
  --nThreads "$NTHREADS" \\
  --customise Configuration/DataProcessing/Utils.addMonitoring \\
  --no_exec

run_cfg "${{BASE_HLT}}_cfg.py" "${{BASE_HLT}}.root"

INPUT_RECO="file:${{BASE_HLT}}.root"

# =========================================
# PASS 4: RECO -> AODSIM
# =========================================
BASE_AOD="$RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-job$JOBID-AODSIM"

cmsDriver.py stepRECO \\
  --python_filename "${{BASE_AOD}}_cfg.py" \\
  --eventcontent AODSIM \\
  --datatier AODSIM \\
  --step RAW2DIGI,L1Reco,RECO \\
  --filein  "$INPUT_RECO" \\
  --fileout "file:${{BASE_AOD}}.root" \\
  --conditions "$CONDITIONS" \\
  --geometry DB:Extended \\
  --era "$ERA" \\
  --mc -n "$NEVENTS" \\
  --nThreads "$NTHREADS" \\
  --customise Configuration/DataProcessing/Utils.addMonitoring \\
  --no_exec

run_cfg "${{BASE_AOD}}_cfg.py" "${{BASE_AOD}}.root"

# =========================================
# PASS 5: MiniAOD
# =========================================
BASE_MINI=""
if [[ "$DO_MINIAOD" == "1" ]]; then
  BASE_MINI="$RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-job$JOBID-MINIAODSIM"

  cmsDriver.py stepMINIAOD \\
    --python_filename "${{BASE_MINI}}_cfg.py" \\
    --eventcontent MINIAODSIM \\
    --datatier MINIAODSIM \\
    --step PAT \\
    --filein  "file:${{BASE_AOD}}.root" \\
    --fileout "file:${{BASE_MINI}}.root" \\
    --conditions "$CONDITIONS" \\
    --geometry DB:Extended \\
    --era "$ERA" \\
    --mc -n "$NEVENTS" \\
    --nThreads "$NTHREADS" \\
    --customise Configuration/DataProcessing/Utils.addMonitoring \\
    --no_exec

  run_cfg "${{BASE_MINI}}_cfg.py" "${{BASE_MINI}}.root"
fi

# =========================================
# PASS 6: NanoAOD
# =========================================
BASE_NANO=""
if [[ "$DO_NANOAOD" == "1" ]]; then
  if [[ "$DO_MINIAOD" != "1" ]]; then
    echo "[fatal] NanoAOD requires MiniAOD."
    exit 40
  fi

  BASE_NANO="$RUN-$CMSSW_VERSION-n$NEVENTS-$TAG-job$JOBID-NANOAODSIM"

  cmsDriver.py stepNANO \\
    --python_filename "${{BASE_NANO}}_cfg.py" \\
    --eventcontent NANOAODSIM \\
    --datatier NANOAODSIM \\
    --step NANO \\
    --filein  "file:${{BASE_MINI}}.root" \\
    --fileout "file:${{BASE_NANO}}.root" \\
    --conditions "$CONDITIONS" \\
    --geometry DB:Extended \\
    --era "$ERA" \\
    --mc -n "$NEVENTS" \\
    --nThreads "$NTHREADS" \\
    --customise Configuration/DataProcessing/Utils.addMonitoring \\
    --customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))" \\
    --no_exec

  run_cfg "${{BASE_NANO}}_cfg.py" "${{BASE_NANO}}.root"
fi

# =========================================
# Copy outputs back
# =========================================
cd "$TOPDIR"

to_copy=(
  "${{BASE_GENSIM}}.root"
  "${{BASE_DIGIRAW}}.root"
  "${{BASE_HLT}}.root"
  "${{BASE_AOD}}.root"
)

cfg_copy=(
  "${{BASE_GENSIM}}_cfg.py"
  "${{BASE_DIGIRAW}}_cfg.py"
  "${{BASE_HLT}}_cfg.py"
  "${{BASE_AOD}}_cfg.py"
)

if [[ "$DO_MINIAOD" == "1" ]]; then
  to_copy+=("${{BASE_MINI}}.root")
  cfg_copy+=("${{BASE_MINI}}_cfg.py")
fi
if [[ "$DO_NANOAOD" == "1" ]]; then
  to_copy+=("${{BASE_NANO}}.root")
  cfg_copy+=("${{BASE_NANO}}_cfg.py")
fi

OUTDIR_CMSSW="$TOPDIR/$CMSSW_VERSION/src"

for f in "${{to_copy[@]}}"; do
  if [[ -f "$OUTDIR_CMSSW/$f" ]]; then
    cp -v "$OUTDIR_CMSSW/$f" "$TOPDIR/"
  else
    echo "[warn] Missing output: $OUTDIR_CMSSW/$f"
  fi
done

for c in "${{cfg_copy[@]}}"; do
  if [[ -f "$OUTDIR_CMSSW/$c" ]]; then
    cp -v "$OUTDIR_CMSSW/$c" "$TOPDIR/"
  else
    echo "[warn] Missing cfg: $OUTDIR_CMSSW/$c"
  fi
done

# =========================================
# Upload to EOS
# =========================================
EOS_ROOTFILES_URL="{EOS_ROOTFILES_URL}"
EOS_ROOTFILES_REL="{EOS_ROOTFILES_REL}"
EOS_CFGS_URL="{EOS_CFGS_URL}"
EOS_CFGS_REL="{EOS_CFGS_REL}"

echo "[eos] mkdir -p $EOS_ROOTFILES_REL and $EOS_CFGS_REL"
xrdfs cmseos.fnal.gov mkdir -p "$EOS_ROOTFILES_REL" || true
xrdfs cmseos.fnal.gov mkdir -p "$EOS_CFGS_REL" || true

echo "[eos] upload ROOT files"
for f in "${{to_copy[@]}}"; do
  if [[ -f "$TOPDIR/$f" ]]; then
    xrdcp -f "$TOPDIR/$f" "$EOS_ROOTFILES_URL$f"
  fi
done

echo "[eos] upload cfg files"
for c in "${{cfg_copy[@]}}"; do
  if [[ -f "$TOPDIR/$c" ]]; then
    xrdcp -f "$TOPDIR/$c" "$EOS_CFGS_URL$c"
  fi
done

echo "[done] workflow complete"
"""
        )

    return str(exec_file)


def main():
    ap = ArgumentParser()
    args = ap.parse_args()

    # You said HLT is mandatory in this version
    args.do_hlt = True

    if not args.fragment:
        ap.error("You must provide a fragment file via -i/--fragment (or --in).")
    if not os.path.isfile(args.fragment):
        ap.error(f"Fragment file does not exist: {args.fragment}")
    if args.threads < 1:
        ap.error("--threads must be >= 1")
    if args.do_nanoaod and not args.do_miniaod:
        ap.error("NanoAOD requires MiniAOD. Don’t disable MiniAOD if you enable NanoAOD.")
    if args.do_premix and not args.pileup_input.strip():
        ap.error("--do-premix requires --pileup-input (either dbs:/.../PREMIX or a local file list)")

    # Create local directories
    exec_dir = Path(EXEC_NAME)
    logs_dir = Path(LOGS_NAME)
    out_dir = Path(args.out)

    exec_dir.mkdir(exist_ok=True)
    logs_dir.mkdir(exist_ok=True)
    out_dir.mkdir(parents=True, exist_ok=True)

    # Generate executable + submit file
    exec_file = create_exec_file(
        run=args.run,
        fragment_path=args.fragment,
        exec_dir=exec_dir,
        tag=args.tag,
        nevents=args.nevents,
        xqcut=args.xqcut,
        cmssw_version=args.cmssw,
        do_premix=args.do_premix,
        pileup_input=args.pileup_input,
        do_hlt=args.do_hlt,
        hlt_menu=args.hlt_menu,
        do_miniaod=args.do_miniaod,
        do_nanoaod=args.do_nanoaod,
        conditions=args.conditions,
        era=args.era,
        beamspot=args.beamspot,
        threads=args.threads,
    )

    exec_abs = os.path.abspath(exec_file)
    os.chmod(exec_abs, 0o755)

    transfer_inputs = [args.fragment]
    if args.do_premix and args.pileup_input and os.path.isfile(args.pileup_input):
        transfer_inputs.append(args.pileup_input)

    submit_file = create_submit_file(
        run=args.run,
        transfer_inputs=transfer_inputs,
        njobs=args.njobs,
        queue=args.queue,
        exec_file=exec_abs,
        logs_dir=str(logs_dir),
        request_cpus=args.threads,
        desired_os=args.desired_os,
        singularity_image=args.singularity_image,
    )

    print(f"[ok] Wrote exec:    {exec_abs}")
    print(f"[ok] Wrote submit: {submit_file}\n")
    print("Next command:")
    print(f"  condor_submit {submit_file}\n")

    if args.do_premix:
        if args.pileup_input.startswith("dbs:"):
            print("Premix pileup input is DBS-based.")
        else:
            print("Premix pileup input is a local file list; it will be shipped via transfer_input_files.")

    print(f"This submission requests {args.threads} CPU core(s) and runs cmsDriver with --nThreads {args.threads}.")


if __name__ == "__main__":
    main()
