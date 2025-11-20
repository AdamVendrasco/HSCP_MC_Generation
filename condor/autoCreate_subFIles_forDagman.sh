#! /bin/bash
PYTHON=python3
GP_SCRIPT="condor_generate_gridpacks.py"

OUT_DIR="/eos/uscms/store/user/avendras/HSCP/gridpack_output/tarballs/RunIII"
MASS=700
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

# After generating file this will move all files from the freshly created SUBDIR into the BASE_TARGET directory.
#If it already exists, it will move the newly generated files into it.
SUBDIR="generate_gridpack_subfiles-${TAG}"
BASE_TARGET="condor_submit_files"
TARGET_DIR="${BASE_TARGET}/${SUBDIR}"

mkdir -p "${BASE_TARGET}"

if [ -d "${SUBDIR}" ]; then
  if [ -d "${TARGET_DIR}" ]; then
    echo "Target ${TARGET_DIR} already exists; moving new files into it."x
    mv "${SUBDIR}/"* "${TARGET_DIR}/"
    rmdir "${SUBDIR}" 2>/dev/null || true
  else
    echo "Moving ${SUBDIR} -> ${TARGET_DIR}"
    mv "${SUBDIR}" "${TARGET_DIR}"
  fi
else
  echo "WARNING: ${SUBDIR} not found; nothing to move."
fi
