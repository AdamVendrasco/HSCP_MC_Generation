#!/usr/bin/env python
import os
import sys
from pathlib import Path
import argparse
import time
import getpass

nobackup = f'/uscms_data/d1/{getpass.getuser()}'

tagname = 'Run2023'

goutput = f'{nobackup}/gridpack/wplustest'
cinput = f'{nobackup}/mg5work/mycards/wplustest'

EXEC_NAME = "batchexec"
LOGS_NAME = "batchlogs"

WORK_DIR = os.getcwd()

class ArgumentParser(argparse.ArgumentParser):
    def __init__(self):
        super().__init__(usage="%(prog)s [options]")
        self.add_argument("--tag", type=str, default=tagname)
        self.add_argument("--xqcut", type=int)
        self.add_argument("-f", "--force", action="store_true")
        self.add_argument("-o", "--out", type=str, default=goutput)
        self.add_argument("-i", "--in", dest="inF", type=str, default=cinput)
        self.add_argument("-q", "--queue", type=str, default="tomorrow")
        self.add_argument("-j", "--jobs", type=int, default=4)
        self.add_argument("-p", "--pretend", action="store_true")

def create_submit_file(process, cards, tag, jobs, queue, exec_file, logs_dir, xqcut):
    xqcut_tag = f"xqcut{xqcut}" if xqcut is not None else "xqcutNA"
    submit_file = 'submit.sub'
    with open(submit_file, 'w') as fi:
        fi.write(f"""\
executable              = {exec_file}
arguments               = $(ClusterId)$(ProcId)
transfer_input_files    = {cards}
should_transfer_files   = YES
when_to_transfer_output = ON_EXIT
output                  = {logs_dir}/{process}_{xqcut_tag}_$(ClusterId).$(ProcId).out
error                   = {logs_dir}/{process}_{xqcut_tag}_$(ClusterId).$(ProcId).err
log                     = {logs_dir}/{process}_{xqcut_tag}.log
request_cpus            = {jobs}
+JobFlavour             = "{queue}"
+ApptainerImage         = "/cvmfs/singularity.opensciencegrid.org/cmssw/cms:rhel7"
request_memory          = 8000

queue 1
""")


def create_exec_file(process, cardsdir, exec_dir, out_dir, xqcut=None):
    # unique exec name per xqcut so Condor never uses a stale spooled script
    xqcut_tag = f"xqcut{xqcut}" if xqcut is not None else "xqcutNA"
    exec_file = f'{exec_dir}/job_{process}_{xqcut_tag}.sh'
    xqcut_str = str(xqcut) if xqcut is not None else ""

    with open(exec_file, 'w') as fi:
        fi.write(f"""#!/bin/bash
set -euo pipefail
shopt -s nullglob

echo ""
echo "$(date) at $(hostname)"
echo ""

workarea="$PWD"
PROCESS="{process}"
SCRAM_ARCH="slc7_amd64_gcc700"
CMSSW_VERSION="CMSSW_10_6_47"
XQCUT="{xqcut_str}"
OUTDIR="{out_dir}"

echo "PROCESS=$PROCESS"
echo "XQCUT=$XQCUT"

git clone https://github.com/cms-sw/genproductions.git --depth=1 -b mg265UL
cd genproductions
git config core.sparsecheckout true
echo Utilities/scripts/ >> .git/info/sparse-checkout
echo MetaData >> .git/info/sparse-checkout
echo bin/MadGraph5_aMCatNLO >> .git/info/sparse-checkout
git read-tree -m -u HEAD
cd bin/MadGraph5_aMCatNLO/

mkdir -p cards/${{PROCESS}}
cp "$workarea"/${{PROCESS}}_*.dat cards/${{PROCESS}}/

echo "./cards/${{PROCESS}}/:"
ls -l cards/${{PROCESS}}/ || true

chmod +x gridpack_generation.sh
./gridpack_generation.sh ${{PROCESS}} cards/${{PROCESS}} local ALL ${{SCRAM_ARCH}} ${{CMSSW_VERSION}}

# Move the outputs back to the workarea first
mv ${{PROCESS}}*_tarball.tar.xz "$workarea"/
[[ -f ${{PROCESS}}.log ]] && mv ${{PROCESS}}.log "$workarea"/ || true

# Add xqcut tag to filenames (if provided)
cd "$workarea"
for f in ${{PROCESS}}*_tarball.tar.xz; do
  base="${{f%_tarball.tar.xz}}"
  new="${{base}}_xqcut${{XQCUT:-NA}}_tarball.tar.xz"
  mv "$f" "$new"
  echo "RENAMED_TARBALL=$new"
done

if [[ -f "${{PROCESS}}.log" ]]; then
  mv "${{PROCESS}}.log" "${{PROCESS}}_xqcut${{XQCUT:-NA}}.log"
  echo "RENAMED_LOG=${{PROCESS}}_xqcut${{XQCUT:-NA}}.log"
fi

# Stage to OUTDIR if set
if [[ -n "$OUTDIR" ]]; then
  mkdir -p "$OUTDIR"
  for f in ${{PROCESS}}*_xqcut*_tarball.tar.xz ${{PROCESS}}_xqcut*.log; do
    [[ -f "$f" ]] && cp -p "$f" "$OUTDIR"/
  done
  echo "Staged outputs to $OUTDIR"
fi

echo "Done."
""")
    os.system(f"chmod +x {exec_file}")
    return exec_file


def get_cards(path, process):
    files = [f'{path}/{process}_proc_card.dat',
             f'{path}/{process}_run_card.dat',
             f'{path}/{process}_param_card.dat']
    return ','.join(files)

def create_dirs(tag):
    exec_dir = f'{EXEC_NAME}_{tag}'
    logs_dir = f'{LOGS_NAME}_{tag}'
    os.makedirs(exec_dir, exist_ok=True)
    os.makedirs(logs_dir, exist_ok=True)
    return exec_dir, logs_dir

if __name__ == "__main__":
    args = ArgumentParser().parse_args()

    process_name = Path(args.inF).parent.name
    print('Process:', process_name)

    exec_dir, logs_dir = create_dirs(args.tag)

    if "/afs/" in args.out and not args.force:
        raise RuntimeError("Sending gridpacks to afs. Run with -f to force.")
    os.makedirs(args.out, exist_ok=True)

    EXECFILE = create_exec_file(process_name, args.inF, exec_dir, args.out, xqcut=args.xqcut)

    cards = get_cards(args.inF, process_name)

    create_submit_file(process_name, cards, args.tag, args.jobs, args.queue, EXECFILE, logs_dir, args.xqcut)

    if not args.pretend:
        time.sleep(2)
        os.system("condor_submit submit.sub")
        os.system("condor_q")
