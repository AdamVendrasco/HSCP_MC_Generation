#!/bin/sh
echo ""
echo `date` at `hostname`
echo ""
workarea=$PWD
PROCESS="mg-Rhadron_mGl-1000"
LOCAL="false"

# Sparse checkout of genproductions
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

# Create cards directory and copy input cards
mkdir cards/${PROCESS}
if $LOCAL; then
  cp /uscms/home/avendras/nobackup/HSCP/run_directories/${PROCESS}/input-cards/${PROCESS}*.dat cards/${PROCESS}/
else
  cp $workarea/${PROCESS}*.dat cards/${PROCESS}/
fi

echo "./cards/${PROCESS}/:"
ls cards/${PROCESS}/

# Run gridpack generation
if [ ! -d cards/${PROCESS} ]; then 
  echo "ERROR: cards/${PROCESS} does NOT exist"
else
  sh gridpack_generation.sh ${PROCESS} cards/${PROCESS}
  
  # Move tarball and log to Condor top-level directory for transfer
  mv ${PROCESS}*.tar.xz $workarea/
  mv ${PROCESS}.log $workarea/
fi

sleep 3
