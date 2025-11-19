#! /bin/bash
PYTHON=python3
GP_SCRIPT="condor_generate_gridpacks.py"

OUT_DIR="/eos/uscms/store/user/avendras/HSCP/gridpack_output/tarballs/RunIII"
MASS=1600                           
TAG="HSCPstop_M-${MASS}"
QUEUE="tomorrow"
JOBS=2
XQCUTS="10 20 40 60 80 100 110 120 130 140 150 160 170"

for XQCUT in ${XQCUTS}; do
  IN_DIR="/uscms/home/avendras/nobackup/HSCP/run_directories/Run-3/stop-based/HSCPstop_M-${MASS}_xqcut${XQCUT}/"

  echo "Running: xqcut=${XQCUT}, in=${IN_DIR}"

  ${PYTHON} ${GP_SCRIPT} \
    --in "${IN_DIR}" \
    --out "${OUT_DIR}" \
    --tag "${TAG}" \
    --xqcut "${XQCUT}" \
    --queue "${QUEUE}" \
    --jobs ${JOBS} \
    --pretend
done
