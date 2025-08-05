#!/usr/bin/env python
import os
import sys
import pathlib
import argparse
import time
import getpass

'''
example command
python3 generate_gridpack.py --tag Run2023 -o <path_to_output dir> -i <path_to_cards> -q nextweek -j 8
'''
nobackup='/uscms_data/d1/{username}'.format(username=getpass.getuser())

tagname='Run2023'

goutput='{basedir}/gridpack/wplustest'.format(basedir=nobackup)
cinput ='{basedir}/mg5work/mycards/wplustest'.format(basedir=nobackup)

tarball_prefix='_el8_amd64_gcc10_CMSSW_12_4_8_tarball.tar.xz'
tarball_prefix='_tarball.tar.xz'

EXEC_NAME="batchexec"
LOGS_NAME="batchlogs"
RUNS_NAME="batchruns"

WORK_DIR=os.getcwd()

class ArgumentParser(argparse.ArgumentParser):
  def __init__(self):
    argparse.ArgumentParser.__init__(self, usage="%(prog)s <action> <command file> [options]")
    self.add_argument("--tag"         , dest="tag"       , type=str           , default=tagname , help="An identifier of the run, please take into account that the code will rewrite files by default, so change tag accordingly")
    self.add_argument("-f","--force"  , dest="force"     , action="store_true", default=False , help="Force temp folder recreation and just overall ignore warnings.")
    # self.add_argument("-o","--out"    , dest="out"       , type=str           , default=os.getcwd(), help="Output folder for gridpacks, default is running one which probably is a bad idea")
    self.add_argument("-o","--out"    , dest="out"       , type=str           , default=goutput, help="Output folder for gridpacks, default is running one which probably is a bad idea")
    # self.add_argument("-i","--in"     , dest="inF"       , type=str           , default=None, help="Input folder with the cards")
    self.add_argument("-i","--in"     , dest="inF"       , type=str           , default=cinput, help="Input folder with the cards")
    self.add_argument("-q","--queue"  , dest="queue"     , type=str           , default="tomorrow", help="Condor queue to be used. Default is tomorrow (1 day). Other logical options are testmatch (3 days), nextweek (1 week), workday (8 hours)" )
    self.add_argument("-j","--jobs"   , dest="jobs"      , type=int           , default="4", help="Request this number of cores per job" )
    self.add_argument("-n","--new"    , dest="new"       , action="store_true", default=False , help="If activated, will check if gridpack already exists in destination and skip submission if it does")
    self.add_argument("-p","--pretend", dest="pretend"   , action="store_true", default=False , help="Only create folders, don't run anything")
    self.add_argument("-l","--local",   dest="local"     , action="store_true", default=False , help="Only create folders, don't run anything")


def create_submit_file(process, cards, tag, jobs, queue):
  submit_file = 'submit.sub'
  with open(submit_file,'w') as fi:
    fi.write("""\
executable              = $(filename)
arguments               = $(ClusterId)$(ProcId)
transfer_input_files    = {CARDS}
output                  = batchlogs_{TAG}/{PROCESS}_$(ClusterId).$(ProcId).out
error                   = batchlogs_{TAG}/{PROCESS}_$(ClusterId).$(ProcId).err
log                     = batchlogs_{TAG}/{PROCESS}_$(ClusterId).log
RequestCPUs             = {JOBS}
+JobFlavour             = "{QUEUE}"
## +MaxRuntime          = 2000000

queue filename matching (batchexec_{TAG}/job_{PROCESS}.sh)""".format(PROCESS=process, CARDS=cards, TAG=tag, JOBS=jobs, QUEUE=queue))
    fi.close()


def create_exec_file(process, cardsdir, outdir, exec_dir, logs_dir, local):
  exec_file = '{}/job_{}.sh'.format(exec_dir, process)

  LocalScript="true" if local else "false"

  with open(exec_file,'w') as fi:
    fi.write("""#!/bin/sh
echo ""
echo `date` at `hostname`
echo ""
workarea=$PWD
LOCAL="{LOCAL}"
# First we do a sparse checkout of genproductions to avoid copying the whole thing and to also have the latests set of patches available
# We might want to fix a commit sha here to ensure it doesn't pull some tricks
git clone https://github.com/cms-sw/genproductions.git --no-checkout genproductions --depth 1
cd genproductions
git config core.sparsecheckout true
echo Utilities/scripts/ >> .git/info/sparse-checkout
echo MetaData >> .git/info/sparse-checkout
echo bin/MadGraph5_aMCatNLO >> .git/info/sparse-checkout
git read-tree -m -u HEAD
cd bin/MadGraph5_aMCatNLO/

echo ""
echo "Entering '$PWD'"
echo ""

# Copy input cards
#echo "Copy input cards from: {CARDSDIR}"
#ls {CARDSDIR}

#cp -r {CARDSDIR} ./cards/
#xrdcp -r {CARDSDIR} ./cards/

# Create cards
mkdir cards/{PROCESS}
if $LOCAL; then
  cp {CARDSDIR}/{PROCESS}*.dat cards/{PROCESS}/
else
  cp $workarea/{PROCESS}*.dat cards/{PROCESS}/
fi
echo "./cards/{PROCESS}/:"
ls cards/{PROCESS}/


echo ""
if [ ! -d cards/{PROCESS} ]; then echo "ERROR: cards/{PROCESS} does NOT exist"
else
  #Run the script
  sh gridpack_generation.sh {PROCESS} cards/{PROCESS}
  #Copy the gridpack back to somewhere readable
  mv {PROCESS}*.tar.xz {OUTDIR}/
  mv {PROCESS}.log {WORKDIR}/{LOGSDIR}/
fi

sleep 3
#Do some cleanup just to be tidy
cd ../../../
ls
rm -rf genproductions""".format(CARDSDIR=cardsdir, PROCESS=process, OUTDIR=outdir, LOGSDIR=logs_dir, WORKDIR=WORK_DIR, LOCAL=LocalScript))

  return exec_file

def get_cards(path, absolute_path=False):
  files = os.listdir('{}'.format(path))
  if absolute_path:
    files = [f'{path}/{f}' for f in files]
  return ','.join(files)


def create_dirs(TAG, LOCAL):
  exec_dir='{}_{}'.format(EXEC_NAME, TAG)
  logs_dir='{}_{}'.format(LOGS_NAME, TAG)
  runs_dir='{}_{}'.format(RUNS_NAME, TAG)

  if not (os.path.isdir(exec_dir) or os.path.isdir(logs_dir)):
    print('Creating directories ...')
    os.system("mkdir {}".format(exec_dir))
    os.system("mkdir {}".format(logs_dir))
    print('Done!')
  if (not os.path.isdir(runs_dir)) and LOCAL:
    print('Creating Run directory ...')
    os.system("mkdir {}".format(runs_dir))
    print('Done!')

  return exec_dir,logs_dir,runs_dir

##################################################################################################
##################################################################################################
if __name__ == "__main__":
  args = ArgumentParser().parse_args()

  process_name=args.inF.split('/')[-1]

  print('Process:',process_name)

  # exit()

  exec_dir,logs_dir,runs_dir = create_dirs(args.tag, args.local)

  if "/afs/" in args.out and not(args.force):
    raise RuntimeError("Error: you are sending your final gridpacks to be copied to afs, this might be a bad idea unles you have dedicated space for them. Run with force mode (-f) to force this.")
  elif not(os.path.isdir(args.out)) and not ('root://' in args.out):
    os.system("mkdir {}".format(args.out))

  ##### creating and sending jobs #####

  EXECFILE=create_exec_file(process_name, args.inF, args.out, exec_dir, logs_dir, args.local)

  os.system("chmod 755 {}".format(EXECFILE))

  cards = get_cards(args.inF, True)

  if args.local:
    os.system('cp {} {}/'.format(EXECFILE, runs_dir))
  else:
    create_submit_file(process_name, cards, args.tag, args.jobs, args.queue)

    ###### sends bjobs ######
    if not args.pretend:
      os.system("echo submit.sub")
      time.sleep(3)
      os.system("condor_submit submit.sub")
      
      print()
      print("Your jobs are here:")
      os.system("condor_q")
      print()
      print('END')
      print()