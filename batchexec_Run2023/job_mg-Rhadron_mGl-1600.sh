#!/bin/sh
echo ""
echo `date` at `hostname`
echo ""
workarea=$PWD
PROCESS="mg-Rhadron_mGl-1600"
LOCAL="false"

git clone https://github.com/cms-sw/genproductions.git --no-checkout genproductions --depth 1
cd genproductions
git config core.sparsecheckout true
echo Utilities/scripts/ >> .git/info/sparse-checkout
echo MetaData >> .git/info/sparse-checkout
echo bin/MadGraph5_aMCatNLO >> .git/info/sparse-checkout
git read-tree -m -u HEAD
cd bin/MadGraph5_aMCatNLO/

mkdir cards/${PROCESS}
cp $workarea/${PROCESS}_*.dat cards/${PROCESS}/

echo "./cards/${PROCESS}/:"
ls cards/${PROCESS}/

if [ ! -d cards/${PROCESS} ]; then 
  echo "ERROR: cards/${PROCESS} does NOT exist"
else
  sh gridpack_generation.sh ${PROCESS} cards/${PROCESS}
  mv ${PROCESS}*.tar.xz $workarea/
  mv ${PROCESS}.log $workarea/
fi

sleep 3
