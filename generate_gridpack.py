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
        self.add_argument("-f", "--force", action="store_true")
        self.add_argument("-o", "--out", type=str, default=goutput)
        self.add_argument("-i", "--in", dest="inF", type=str, default=cinput)
        self.add_argument("-q", "--queue", type=str, default="tomorrow")
        self.add_argument("-j", "--jobs", type=int, default=4)
        self.add_argument("-p", "--pretend", action="store_true")

def create_submit_file(process, cards, tag, jobs, queue):
    submit_file = 'submit.sub'
    with open(submit_file, 'w') as fi:
        fi.write(f"""\
executable              = $(filename)
arguments               = $(ClusterId)$(ProcId)
transfer_input_files    = {cards}
output                  = batchlogs_{tag}/{process}_$(ClusterId).$(ProcId).out
error                   = batchlogs_{tag}/{process}_$(ClusterId).$(ProcId).err
log                     = batchlogs_{tag}/{process}_$(ClusterId).log
RequestCPUs             = {jobs}
+JobFlavour             = \"{queue}\"
+ApptainerImage         = "/cvmfs/singularity.opensciencegrid.org/cmssw/cms:rhel7"
request_memory          = 8000

queue filename matching (batchexec_{tag}/job_{process}.sh)
""")

def create_exec_file(process, cardsdir, exec_dir):
    exec_file = f'{exec_dir}/job_{process}.sh'

    with open(exec_file, 'w') as fi:
        fi.write(f"""#!/bin/sh
echo ""
echo `date` at `hostname`
echo ""
workarea="$PWD"
PROCESS="{process}"
SCRAM_ARCH="slc7_amd64_gcc700"
CMSSW_VERSION="CMSSW_10_6_47"
LOCAL="false"

git clone https://github.com/cms-sw/genproductions.git --no-checkout genproductions --depth 1
cd genproductions
git config core.sparsecheckout true
echo Utilities/scripts/ >> .git/info/sparse-checkout
echo MetaData >> .git/info/sparse-checkout
echo bin/MadGraph5_aMCatNLO >> .git/info/sparse-checkout
git read-tree -m -u HEAD
cd bin/MadGraph5_aMCatNLO/

mkdir cards/${{PROCESS}}
cp $workarea/${{PROCESS}}_*.dat cards/${{PROCESS}}/

echo "./cards/${{PROCESS}}/:"
ls cards/${{PROCESS}}/

if [ ! -d cards/${{PROCESS}} ]; then 
  echo "ERROR: cards/${{PROCESS}} does NOT exist"
else
  ./gridpack_generation.sh ${{PROCESS}} cards/${{PROCESS}} local ALL ${{SCRAM_ARCH}} ${{CMSSW_VERSION}}
  mv ${{PROCESS}}*.tar.xz $workarea/
  mv ${{PROCESS}}.log $workarea/
fi

sleep 3
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

    EXECFILE = create_exec_file(process_name, args.inF, exec_dir)

    cards = get_cards(args.inF, process_name)

    create_submit_file(process_name, cards, args.tag, args.jobs, args.queue)

    if not args.pretend:
        time.sleep(2)
        os.system("condor_submit submit.sub")
        os.system("condor_q")
