#!/usr/bin/env python3
import os
import time
import getpass
import argparse
from pathlib import Path
from typing import Optional

# -----------------------------
# Defaults
# -----------------------------
USER = getpass.getuser()
NOBACKUP_DIR = f"/uscms_data/d1/{USER}"

DEFAULT_TAG = "Run2023"
DEFAULT_OUTPUT_DIR = f"{NOBACKUP_DIR}/gridpack/wplustest"
DEFAULT_CARDS_DIR = f"{NOBACKUP_DIR}/mg5work/mycards/wplustest"
DEFAULT_QUEUE = "tomorrow"
DEFAULT_CPUS = 4

EXEC_SCRIPTS_DIR_PREFIX = "batchexec"
LOGS_DIR_PREFIX = "batchlogs"

# EL8 defaults
DEFAULT_SCRAM_ARCH = "el8_amd64_gcc12"
DEFAULT_CMSSW_VERSION = "CMSSW_14_0_22"
DEFAULT_CONTAINER = "/cvmfs/singularity.opensciencegrid.org/cmssw/cms:rhel8"


# -----------------------------
# Arg parsing
# -----------------------------
def parse_arguments():
    parser = argparse.ArgumentParser(description="Gridpack Condor Submitter (EL8)")
    parser.add_argument("--tag", type=str, default=DEFAULT_TAG, help="Tag name for output dirs")
    parser.add_argument("--xqcut", type=int, default=None, help="XQCUT value (only used for renaming)")
    parser.add_argument("-i", "--in", dest="cards_dir", type=str, default=DEFAULT_CARDS_DIR, help="Input cards directory (contains <process>_proc/run/param_card.dat)")
    parser.add_argument("-o", "--out", type=str, default=DEFAULT_OUTPUT_DIR, help="Output directory (NOTE: in this version we rely on Condor transfer; OUTDIR staging is not used)")
    parser.add_argument("-q", "--queue", type=str, default=DEFAULT_QUEUE, help='HTCondor job flavour (e.g. "tomorrow", "workday", ...)')
    parser.add_argument("-j", "--jobs", type=int, default=DEFAULT_CPUS, help="request_cpus")
    parser.add_argument("-p", "--pretend", action="store_true", help="Dry run (do not submit)")
    parser.add_argument("--scram-arch", type=str, default=DEFAULT_SCRAM_ARCH, help="SCRAM_ARCH to use inside job (EL8 recommended)")
    parser.add_argument("--cmssw", type=str, default=DEFAULT_CMSSW_VERSION, help="CMSSW_VERSION to pass to gridpack_generation.sh")
    parser.add_argument("--container", type=str, default=DEFAULT_CONTAINER, help="Singularity/Apptainer image path for condor")
    parser.add_argument("-f", "--force", action="store_true", help="Allow output directories under /afs (normally discouraged)")
    parser.add_argument("--pretendclear", action="store_true", help="Alias for --pretend (kept for backward compatibility)")

    return parser.parse_args()


# -----------------------------
# Helpers
# -----------------------------
def prepare_directories(tag: str):
    exec_dir = f"{EXEC_SCRIPTS_DIR_PREFIX}_{tag}"
    logs_dir = f"{LOGS_DIR_PREFIX}_{tag}"
    os.makedirs(exec_dir, exist_ok=True)
    os.makedirs(logs_dir, exist_ok=True)
    return exec_dir, logs_dir


def select_process_name(cards_dir_path: str) -> str:
    cards_path = Path(cards_dir_path)
    return cards_path.name if cards_path.is_dir() else cards_path.stem


def discover_cards(cards_dir: str, process_name: str) -> str:
    expected = [
        f"{cards_dir}/{process_name}_proc_card.dat",
        f"{cards_dir}/{process_name}_run_card.dat",
        f"{cards_dir}/{process_name}_param_card.dat",
    ]
    missing = [p for p in expected if not os.path.exists(p)]
    if missing:
        raise FileNotFoundError("Missing required card files:\n  " + "\n  ".join(missing))
    return ",".join(expected)


def check_afs_restriction(output_dir: str, force: bool):
    if "/afs/" in output_dir and not force:
        raise RuntimeError("Output is under /afs. Use -f/--force to allow.")


# -----------------------------
# File generation
# -----------------------------
def create_condor_submit_file(process: str, card_files_csv: str, tag: str, num_cpus: int,
                              jobflavour: str, exec_script_path: str, logs_dir: str, container_image: str) -> str:
    submit_dir = f"generate_gridpack_subfiles-{tag}"
    os.makedirs(submit_dir, exist_ok=True)
    submit_path = os.path.join(submit_dir, f"{process}.sub")

    with open(submit_path, "w") as sub:
        sub.write(f"""\
executable              = {exec_script_path}
arguments               = $(ClusterId) $(ProcId)

transfer_input_files    = {card_files_csv}
should_transfer_files   = YES
when_to_transfer_output = ON_EXIT
output                  = {logs_dir}/{process}_$(ClusterId).$(ProcId).out
error                   = {logs_dir}/{process}_$(ClusterId).$(ProcId).err
log                     = {logs_dir}/{process}.log

request_cpus            = {num_cpus}
request_memory          = 8000

+JobFlavour             = "{jobflavour}"
+DesiredOS              = "rhel8"
+SingularityImage       = "{container_image}"

queue 1
""")
    return submit_path


def generate_exec_script(process: str,
                         exec_dir: str,
                         xqcut: Optional[int],
                         scram_arch: str,
                         cmssw_version: str) -> str:
    exec_script_path = os.path.join(exec_dir, f"job_{process}.sh")
    xqcut_str = str(xqcut) if xqcut is not None else ""

    with open(exec_script_path, "w") as script:
        script.write(f"""#!/bin/bash
set -euo pipefail
shopt -s nullglob

echo ""
echo "$(date) at $(hostname)"
echo ""

WORKDIR="$PWD"
PROCESS="{process}"
SCRAM_ARCH="{scram_arch}"
CMSSW_VERSION="{cmssw_version}"
XQCUT="{xqcut_str}"

echo "WORKDIR=$WORKDIR"
echo "PROCESS=$PROCESS"
echo "SCRAM_ARCH=$SCRAM_ARCH"
echo "CMSSW_VERSION=$CMSSW_VERSION"
echo "XQCUT=$XQCUT"

export SCRAM_ARCH="$SCRAM_ARCH"
set +u
source /cvmfs/cms.cern.ch/cmsset_default.sh
set -u

# --- Get genproductions scripts ---
git clone https://gitlab.cern.ch/cms-gen/genproductions_scripts.git
cd genproductions_scripts/bin/MadGraph5_aMCatNLO/

# --- Put transferred cards into expected location ---
mkdir -p "cards/${{PROCESS}}"
cp "$WORKDIR"/${{PROCESS}}_*.dat "cards/${{PROCESS}}/" || true

echo "cards/${{PROCESS}} contents:"
ls -l "cards/${{PROCESS}}/" || true

chmod +x gridpack_generation.sh

# positional args:
#   NAME CARDDIR RUNHOME QUEUE JOBSTEP SCRAM_ARCH CMSSW_VERSION
./gridpack_generation.sh "${{PROCESS}}" "cards/${{PROCESS}}" "$WORKDIR" "local" "ALL" "$SCRAM_ARCH" "$CMSSW_VERSION"

# --- Bring outputs into WORKDIR so Condor can transfer them back ---
cd "$WORKDIR"

for f in ${{PROCESS}}*_tarball.tar.xz; do
  [[ -f "$f" ]] || continue
  base="${{f%_tarball.tar.xz}}"
  tagged="${{base}}_xqcut${{XQCUT:-NA}}_tarball.tar.xz"
  mv "$f" "$tagged"
  echo "RENAMED_TARBALL=$tagged"
done

if [[ -f "${{PROCESS}}.log" ]]; then
  mv "${{PROCESS}}.log" "${{PROCESS}}_xqcut${{XQCUT:-NA}}.log"
  echo "RENAMED_LOG=${{PROCESS}}_xqcut${{XQCUT:-NA}}.log"
fi

echo "Listing outputs in WORKDIR:"
ls -lh

echo "Done."
""")

    os.chmod(exec_script_path, 0o755)
    return exec_script_path


def main():
    args = parse_arguments()
    pretend = bool(args.pretend or args.pretendclear)

    process_name = select_process_name(args.cards_dir)
    print(f"Process: {process_name}")
    
    check_afs_restriction(args.out, args.force)
    os.makedirs(args.out, exist_ok=True)

    exec_dir, logs_dir = prepare_directories(args.tag)

    exec_script_path = generate_exec_script(
        process=process_name,
        exec_dir=exec_dir,
        xqcut=args.xqcut,
        scram_arch=args.scram_arch,
        cmssw_version=args.cmssw,
    )

    card_files_csv = discover_cards(args.cards_dir, process_name)
    print(f"Cards to transfer: {card_files_csv}")

    submit_path = create_condor_submit_file(
        process=process_name,
        card_files_csv=card_files_csv,
        tag=args.tag,
        num_cpus=args.jobs,
        jobflavour=args.queue,
        exec_script_path=exec_script_path,
        logs_dir=logs_dir,
        container_image=args.container,
    )

    if pretend:
        print(f"[Pretend] Would submit:\n  condor_submit {submit_path}")
        print(f"[Pretend] Exec script:\n  {exec_script_path}")
        return

    time.sleep(1)
    os.system(f"condor_submit {submit_path}")
    os.system(f"condor_q {USER}")

if __name__ == "__main__":
    main()