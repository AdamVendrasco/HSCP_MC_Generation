##!/usr/bin/env python
#import os
#import sys
#from pathlib import Path
#import argparse
#import time
#import getpass
#
#nobackup = f'/uscms_data/d1/{getpass.getuser()}'
#
#tagname = 'Run2023'
#
#goutput = f'{nobackup}/gridpack/wplustest'
#cinput = f'{nobackup}/mg5work/mycards/wplustest'
#
#EXEC_NAME = "batchexec"
#LOGS_NAME = "batchlogs"
#
#WORK_DIR = os.getcwd()
#
#
#class ArgumentParser(argparse.ArgumentParser):
#    def __init__(self):
#        super().__init__(usage="%(prog)s [options]")
#        self.add_argument("--tag", type=str, default=tagname)
#        self.add_argument("--xqcut", type=int)
#        self.add_argument("-f", "--force", action="store_true")
#        self.add_argument("-o", "--out", type=str, default=goutput)
#        self.add_argument("-i", "--in", dest="inF", type=str, default=cinput)
#        self.add_argument("-q", "--queue", type=str, default="tomorrow")
#        self.add_argument("-j", "--jobs", type=int, default=4)
#        self.add_argument("-p", "--pretend", action="store_true")
#
#
#def create_submit_file(process, cards, tag, jobs, queue, exec_file, logs_dir, xqcut):
#    """
#    Create a Condor submit file specific to this process/xqcut and
#    return the path to it. The .sub files live in their own directory.
#    """
#    subs_dir = f"generate_gridpack_subfiles-{tag}"
#    os.makedirs(subs_dir, exist_ok=True)
#
#    submit_file = os.path.join(subs_dir, f"{process}.sub")
#
#    with open(submit_file, 'w') as fi:
#        fi.write(f"""\
#executable              = {exec_file}
#arguments               = $(ClusterId)$(ProcId)
#transfer_input_files    = {cards}
#should_transfer_files   = YES
#when_to_transfer_output = ON_EXIT
#output                  = {logs_dir}/{process}_$(ClusterId).$(ProcId).out
#error                   = {logs_dir}/{process}_$(ClusterId).$(ProcId).err
#log                     = {logs_dir}/{process}.log
#request_cpus            = {jobs}
#+JobFlavour             = "{queue}"
#+ApptainerImage         = "/cvmfs/singularity.opensciencegrid.org/cmssw/cms:rhel7"
#request_memory          = 8000
#
#queue 1
#""")
#    return submit_file
#
#
#
#def create_exec_file(process, cardsdir, exec_dir, out_dir, xqcut=None):
#    """
#    Create the bash exec script that runs on the worker node.
#    One exec script per process (process already includes xqcut in its name).
#    """
#    exec_file = f'{exec_dir}/job_{process}.sh'
#    xqcut_str = str(xqcut) if xqcut is not None else ""
#
#    with open(exec_file, 'w') as fi:
#        fi.write(f"""#!/bin/bash
#set -euo pipefail
#shopt -s nullglob
#
#echo ""
#echo "$(date) at $(hostname)"
#echo ""
#
#workarea="$PWD"
#PROCESS="{process}"
#SCRAM_ARCH="slc7_amd64_gcc700"
#CMSSW_VERSION="CMSSW_10_6_47"
#XQCUT="{xqcut_str}"
#OUTDIR="{out_dir}"
#
#echo "PROCESS=$PROCESS"
#echo "XQCUT=$XQCUT"
#
#git clone https://github.com/cms-sw/genproductions.git --depth=1 -b mg265UL
#cd genproductions
#git config core.sparsecheckout true
#echo Utilities/scripts/ >> .git/info/sparse-checkout
#echo MetaData >> .git/info/sparse-checkout
#echo bin/MadGraph5_aMCatNLO >> .git/info/sparse-checkout
#git read-tree -m -u HEAD
#cd bin/MadGraph5_aMCatNLO/
#
#mkdir -p cards/${{PROCESS}}
#cp "$workarea"/${{PROCESS}}_*.dat cards/${{PROCESS}}/
#
#echo "./cards/${{PROCESS}}/:"
#ls -l cards/${{PROCESS}}/ || true
#
#chmod +x gridpack_generation.sh
#./gridpack_generation.sh ${{PROCESS}} cards/${{PROCESS}} local ALL ${{SCRAM_ARCH}} ${{CMSSW_VERSION}}
#
## Move the outputs back to the workarea first
#mv ${{PROCESS}}*_tarball.tar.xz "$workarea"/
#[[ -f ${{PROCESS}}.log ]] && mv ${{PROCESS}}.log "$workarea"/ || true
#
## Add xqcut tag to filenames (if provided)
#cd "$workarea"
#for f in ${{PROCESS}}*_tarball.tar.xz; do
#  base="${{f%_tarball.tar.xz}}"
#  new="${{base}}_xqcut${{XQCUT:-NA}}_tarball.tar.xz"
#  mv "$f" "$new"
#  echo "RENAMED_TARBALL=$new"
#done
#
#if [[ -f "${{PROCESS}}.log" ]]; then
#  mv "${{PROCESS}}.log" "${{PROCESS}}_xqcut${{XQCUT:-NA}}.log"
#  echo "RENAMED_LOG=${{PROCESS}}_xqcut${{XQCUT:-NA}}.log"
#fi
#
## Stage to OUTDIR if set
#if [[ -n "$OUTDIR" ]]; then
#  mkdir -p "$OUTDIR"
#  for f in ${{PROCESS}}*_xqcut*_tarball.tar.xz ${{PROCESS}}_xqcut*.log; do
#    [[ -f "$f" ]] && cp -p "$f" "$OUTDIR"/
#  done
#  echo "Staged outputs to $OUTDIR"
#fi
#
#echo "Done."
#""")
#    os.system(f"chmod +x {exec_file}")
#    return exec_file
#
#
#def get_cards(path, process):
#    files = [
#        f'{path}/{process}_proc_card.dat',
#        f'{path}/{process}_run_card.dat',
#        f'{path}/{process}_param_card.dat',
#    ]
#    return ','.join(files)
#
#
#def create_dirs(tag):
#    exec_dir = f'{EXEC_NAME}_{tag}'
#    logs_dir = f'{LOGS_NAME}_{tag}'
#    os.makedirs(exec_dir, exist_ok=True)
#    os.makedirs(logs_dir, exist_ok=True)
#    return exec_dir, logs_dir
#
#
#if __name__ == "__main__":
#    args = ArgumentParser().parse_args()
#
#    p = Path(args.inF)
#    if p.is_dir():
#        process_name = p.name  # e.g. HSCPstop_M-700_xqcut20
#    else:
#        process_name = p.stem
#    print('Process:', process_name)
#
#    exec_dir, logs_dir = create_dirs(args.tag)
#
#    if "/afs/" in args.out and not args.force:
#        raise RuntimeError("Sending gridpacks to afs. Run with -f to force.")
#    os.makedirs(args.out, exist_ok=True)
#
#    EXECFILE = create_exec_file(process_name, args.inF, exec_dir, args.out, xqcut=args.xqcut)
#
#    cards = get_cards(args.inF, process_name)
#    print("Cards to transfer:", cards)
#
#    submit_file = create_submit_file(
#        process_name, cards, args.tag, args.jobs, args.queue,
#        EXECFILE, logs_dir, args.xqcut
#    )
#
#    if not args.pretend:
#        time.sleep(2)
#        os.system(f"condor_submit {submit_file}")
#        os.system("condor_q")
#

#!/usr/bin/env python3
import os
from pathlib import Path
import argparse
import time
import getpass

# Default paths and configuration
USER = getpass.getuser()
NOBACKUP_DIR = f"/uscms_data/d1/{USER}"
DEFAULT_TAG = "Run2023"
DEFAULT_OUTPUT_DIR = f"{NOBACKUP_DIR}/gridpack/wplustest"
DEFAULT_CARDS_DIR = f"{NOBACKUP_DIR}/mg5work/mycards/wplustest"
DEFAULT_QUEUE = "tomorrow"
DEFAULT_CPUS = 4
EXEC_SCRIPTS_DIR_PREFIX = "batchexec"
LOGS_DIR_PREFIX = "batchlogs"

def parse_arguments():
    """Parse command-line arguments for gridpack submission."""
    parser = argparse.ArgumentParser(description="Gridpack Condor Submitter")
    parser.add_argument("--tag", type=str, default=DEFAULT_TAG, help="Process tag name")
    parser.add_argument("--xqcut", type=int, default=None, help="XQCUT parameter for MadGraph")
    parser.add_argument("-f", "--force", action="store_true", help="Force output to AFS directories")
    parser.add_argument("-o", "--out", type=str, default=DEFAULT_OUTPUT_DIR, help="Output directory for gridpack")
    parser.add_argument("-i", "--in", dest="cards_dir", type=str, default=DEFAULT_CARDS_DIR, help="Input cards directory")
    parser.add_argument("-q", "--queue", type=str, default=DEFAULT_QUEUE, help="HTCondor job flavour")
    parser.add_argument("-j", "--jobs", type=int, default=DEFAULT_CPUS, help="Number of CPUs")
    parser.add_argument("-p", "--pretend", action="store_true", help="Dry run (do not submit jobs)")
    return parser.parse_args()

def prepare_directories(tag):
    """Create working directories for execution scripts and logs, based on tag."""
    exec_dir = f"{EXEC_SCRIPTS_DIR_PREFIX}_{tag}"
    logs_dir = f"{LOGS_DIR_PREFIX}_{tag}"
    os.makedirs(exec_dir, exist_ok=True)
    os.makedirs(logs_dir, exist_ok=True)
    return exec_dir, logs_dir

def select_process_name(cards_dir_path):
    """Get process name from cards directory or file."""
    cards_path = Path(cards_dir_path)
    return cards_path.name if cards_path.is_dir() else cards_path.stem

def discover_cards(cards_dir, process_name):
    """Find required MadGraph card files and return as comma-separated string."""
    expected_cards = [
        f"{cards_dir}/{process_name}_proc_card.dat",
        f"{cards_dir}/{process_name}_run_card.dat",
        f"{cards_dir}/{process_name}_param_card.dat",
    ]
    return ','.join(expected_cards)

def create_condor_submit_file(process, card_files, tag, num_cpus, queue, exec_script_path, logs_dir, xqcut):
    """Create and write Condor submit file for gridpack job."""
    submit_dir = f"generate_gridpack_subfiles-{tag}"
    os.makedirs(submit_dir, exist_ok=True)
    submit_file_path = os.path.join(submit_dir, f"{process}.sub")

    with open(submit_file_path, 'w') as subfile:
        subfile.write(f"""
executable              = {exec_script_path}
arguments               = $(ClusterId)$(ProcId)
transfer_input_files    = {card_files}
should_transfer_files   = YES
when_to_transfer_output = ON_EXIT
output                  = {logs_dir}/{process}_$(ClusterId).$(ProcId).out
error                   = {logs_dir}/{process}_$(ClusterId).$(ProcId).err
log                     = {logs_dir}/{process}.log
request_cpus            = {num_cpus}
+JobFlavour             = "{queue}"
+ApptainerImage         = "/cvmfs/singularity.opensciencegrid.org/cmssw/cms:rhel7"
request_memory          = 8000

queue 1
""")
    return submit_file_path

def generate_exec_script(process, cards_dir, exec_dir, output_dir, xqcut=None):
    """Generate the shell script that gets executed by the worker node."""
    exec_script_path = f"{exec_dir}/job_{process}.sh"
    xqcut_str = str(xqcut) if xqcut is not None else ""

    with open(exec_script_path, 'w') as script:
        script.write(f"""#!/bin/bash
set -euo pipefail
shopt -s nullglob

echo ""
echo "$(date) at $(hostname)"
echo ""

WORKDIR="$PWD"
PROCESS="{process}"
SCRAM_ARCH="slc7_amd64_gcc700"
CMSSW_VERSION="CMSSW_10_6_47"
XQCUT="{xqcut_str}"
OUTDIR="{output_dir}"

echo "PROCESS=$PROCESS"
echo "XQCUT=$XQCUT"

# Setup environment and cards
git clone https://github.com/cms-sw/genproductions.git --depth=1 -b mg265UL
cd genproductions
git config core.sparsecheckout true
echo Utilities/scripts/ >> .git/info/sparse-checkout
echo MetaData >> .git/info/sparse-checkout
echo bin/MadGraph5_aMCatNLO >> .git/info/sparse-checkout
git read-tree -m -u HEAD
cd bin/MadGraph5_aMCatNLO/

mkdir -p cards/${{PROCESS}}
cp "$WORKDIR"/${{PROCESS}}_*.dat cards/${{PROCESS}}/

echo "./cards/${{PROCESS}}/:"
ls -l cards/${{PROCESS}}/ || true

chmod +x gridpack_generation.sh
./gridpack_generation.sh ${{PROCESS}} cards/${{PROCESS}} local ALL ${{SCRAM_ARCH}} ${{CMSSW_VERSION}}

# Move outputs back to workdir and tag filenames
mv ${{PROCESS}}*_tarball.tar.xz "$WORKDIR"/
[[ -f ${{PROCESS}}.log ]] && mv ${{PROCESS}}.log "$WORKDIR"/ || true

cd "$WORKDIR"
for f in ${{PROCESS}}*_tarball.tar.xz; do
  base="${{f%_tarball.tar.xz}}"
  tagged="${{base}}_xqcut${{XQCUT:-NA}}_tarball.tar.xz"
  mv "$f" "$tagged"
  echo "RENAMED_TARBALL=$tagged"
done

if [[ -f "${{PROCESS}}.log" ]]; then
  mv "${{PROCESS}}.log" "${{PROCESS}}_xqcut${{XQCUT:-NA}}.log"
  echo "RENAMED_LOG=${{PROCESS}}_xqcut${{XQCUT:-NA}}.log"
fi

# Stage to OUTDIR if specified and accessible
if [[ -n "$OUTDIR" ]]; then
  mkdir -p "$OUTDIR"
  for f in ${{PROCESS}}*_xqcut*_tarball.tar.xz ${{PROCESS}}_xqcut*.log; do
    [[ -f "$f" ]] && cp -p "$f" "$OUTDIR"/
  done
  echo "Staged outputs to $OUTDIR"
fi

echo "Done."
""")
    os.system(f"chmod +x {exec_script_path}")
    return exec_script_path

def check_afs_restriction(output_dir, force):
    """Refuse to write to AFS unless --force is specified."""
    if "/afs/" in output_dir and not force:
        raise RuntimeError("Sending gridpacks to AFS is discouraged. Use -f to force.")

def main():
    args = parse_arguments()

    # 1. Select process and card info
    process_name = select_process_name(args.cards_dir)
    print(f"Process: {process_name}")

    # 2. Prepare working directories
    exec_dir, logs_dir = prepare_directories(args.tag)

    # 3. Restrict output directory if needed
    check_afs_restriction(args.out, args.force)
    os.makedirs(args.out, exist_ok=True)

    # 4. Create execute script
    exec_script = generate_exec_script(
        process=process_name,
        cards_dir=args.cards_dir,
        exec_dir=exec_dir,
        output_dir=args.out,
        xqcut=args.xqcut
    )

    # 5. Prepare card files string for Condor
    card_files = discover_cards(args.cards_dir, process_name)
    print(f"Cards to transfer: {card_files}")

    # 6. Write Condor submit file
    submit_file_path = create_condor_submit_file(
        process=process_name,
        card_files=card_files,
        tag=args.tag,
        num_cpus=args.jobs,
        queue=args.queue,
        exec_script_path=exec_script,
        logs_dir=logs_dir,
        xqcut=args.xqcut
    )

    # 7. Submit job or dry run
    if args.pretend:
        print(f"[Pretend] Would submit: condor_submit {submit_file_path}")
        return

    time.sleep(2)
    os.system(f"condor_submit {submit_file_path}")
    os.system("condor_q")


if __name__ == "__main__":
    main()