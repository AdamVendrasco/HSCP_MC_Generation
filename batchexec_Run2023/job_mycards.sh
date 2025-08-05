#!/bin/sh

echo ""
echo `date` at `hostname`
echo ""
workarea=$PWD
LOCAL="false"

# sparse clone of genproductions
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

# Copy all .dat cards into cards/mycards/
mkdir -p cards/mycards
if [ "$LOCAL" = "true" ]; then
  cp "/uscms_data/d1/avendras/mg5work/mycards/wplustest"/*.dat cards/mycards/
else
  cp "$workarea"/*.dat cards/mycards/
fi
echo "./cards/mycards/:"
ls cards/mycards/

echo ""
if [ ! -d cards/mycards ]; then
  echo "ERROR: cards/mycards does NOT exist"
else
  sh gridpack_generation.sh mycards cards/mycards
  # Let HTCondor handle output transfer
fi

# cleanup
cd ../../../
rm -rf genproductions
