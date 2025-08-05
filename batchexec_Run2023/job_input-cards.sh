#!/bin/sh
echo ""
echo `date` at `hostname`
echo ""
workarea=$PWD

# Sparse‐checkout genproductions
git clone https://github.com/cms-sw/genproductions.git --no-checkout genproductions --depth 1
cd genproductions
git config core.sparsecheckout true
echo Utilities/scripts/ >> .git/info/sparse-checkout
echo MetaData           >> .git/info/sparse-checkout
echo bin/MadGraph5_aMCatNLO >> .git/info/sparse-checkout
git read-tree -m -u HEAD
cd bin/MadGraph5_aMCatNLO/

echo "Entering '$PWD'"

# Prepare cards
mkdir -p cards/input-cards
if false; then
  cp /uscms/home/avendras/nobackup/HSCP/run_directories/mg-Rhadron_mGl-1000/input-cards/input-cards*.dat cards/input-cards/
else
  cp $workarea/input-cards*.dat cards/input-cards/
fi
echo "./cards/input-cards/:"
ls cards/input-cards/

if [ ! -d cards/input-cards ]; then
  echo "ERROR: cards/input-cards does NOT exist"
else
  # Run the gridpack generation
  sh gridpack_generation.sh input-cards cards/input-cards
  # Move the tarball to your NFS‐mounted output dir
  mv input-cards*.tar.xz /uscms/home/avendras/nobackup/HSCP/tarballs/
  # Move the log back into your batchlogs folder under your submit dir
  mv input-cards.log /uscms_data/d3/avendras/batchlogs_Run2023/
fi

sleep 3
cd ../../../
rm -rf genproductions
