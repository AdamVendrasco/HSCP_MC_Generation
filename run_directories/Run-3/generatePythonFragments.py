#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# Choose ONE template (script will auto-detect stops vs gluinos from this)
# -----------------------------------------------------------------------------
TEMPLATE="HSCPgluinoTemplate_TuneCP5_13p6TeV_madgraphMLM-pythia8.py"
#TEMPLATE="HSCPstopTemplate_TuneCP5_13p6TeV_madgraphMLM-pythia8.py"

MASSES="1000 1100 1200 1300 1400 1500 1600 1800 2000 2200 2400 2600"
#MASSES="700 800 900 1000 1200 1400 1600 1800 2000 2200 2400 2600"
XQCUTS="150"

# -----------------------------------------------------------------------------
# Base dirs for writing fragments (auto-picked based on TEMPLATE)
# -----------------------------------------------------------------------------
BASE_DIR_STOP="/uscms/home/avendras/nobackup/HSCP/run_directories/Run-3/stop-based"
BASE_DIR_GLUINO="/uscms/home/avendras/nobackup/HSCP/run_directories/Run-3/gluino-based"

# -----------------------------------------------------------------------------
# XRootD base for tarballs
# -----------------------------------------------------------------------------
XR_BASE="root://cmseos.fnal.gov//store/user/avendras/HSCP/gridpack_output/tarballs/RunIII"

# baked into your tarball filenames
ARCH_TAG="el8_amd64_gcc12"
CMSSW_TAG="CMSSW_14_0_22"

# -----------------------------------------------------------------------------
# Auto-detect mode from TEMPLATE
# -----------------------------------------------------------------------------
tmpl_lc="$(echo "${TEMPLATE}" | tr '[:upper:]' '[:lower:]')"

if [[ "${tmpl_lc}" == *gluino* ]]; then
  MODE="gluinos"
  BASE_DIR="${BASE_DIR_GLUINO}"
  BASE_NAME_PREFIX="HSCPgluino_M-"
  TAR_SUBDIR="gluinos"
  TAR_PREFIX="HSCP-Gluino_Par-M-"
  FLAVOR_STR="gluino"
elif [[ "${tmpl_lc}" == *stop* ]]; then
  MODE="stops"
  BASE_DIR="${BASE_DIR_STOP}"
  BASE_NAME_PREFIX="HSCPstop_M-"
  TAR_SUBDIR="stops"
  TAR_PREFIX="HSCP-Stop_Par-M-"
  FLAVOR_STR="stop"
else
  echo "[ERROR] Could not infer stops vs gluinos from TEMPLATE='${TEMPLATE}'."
  echo "        Make sure TEMPLATE contains 'stop' or 'gluino' in the filename."
  exit 1
fi

echo "[info] Detected MODE=${MODE}"
echo "[info] Using BASE_DIR=${BASE_DIR}"

for MASS in ${MASSES}; do
  for XQCUT in ${XQCUTS}; do

    XQCUT_TAG="xqcut${XQCUT}"
    BASE_NAME="${BASE_NAME_PREFIX}${MASS}"
    NAME="${BASE_NAME}_${XQCUT_TAG}"

    DIR="${BASE_DIR}/${NAME}"

    if [ ! -d "${DIR}" ]; then
      echo "[WARN] Directory not found, skipping: ${DIR}"
      continue
    fi

    OUTFILE="${DIR}/${NAME}_TuneCP5_13p6TeV_madgraphMLM-pythia8.py"

    # Build tarball path (xrootd) using your new naming convention
    TAR_REL="${TAR_SUBDIR}/${TAR_PREFIX}${MASS}_xqcut${XQCUT}_${ARCH_TAG}_${CMSSW_TAG}_tarball.tar.xz"
    TAR_FULL="${XR_BASE}/${TAR_REL}"

    echo "[info] MASS=${MASS} XQCUT=${XQCUT}"
    echo "       -> ${OUTFILE}"
    echo "       -> ${TAR_FULL}"

    cp "${TEMPLATE}" "${OUTFILE}"

    # -------------------------------------------------------------------------
    # Patch fragment content
    # -------------------------------------------------------------------------

    # 1) Update the ExternalLHEProducer args path
    sed -i -E "s#(args[[:space:]]*=[[:space:]]*cms\\.vstring\\(')[^']*('.*)#\\1${TAR_FULL}\\2#" "${OUTFILE}"

    # 2) Update JetMatching qCut
    sed -i -E "s/'JetMatching:qCut = [0-9.]+\\.',/'JetMatching:qCut = ${XQCUT}.',/" "${OUTFILE}"

    # 3) Update MASS_POINT (drives PARTICLE_FILE/SLHA_FILE/PDT_FILE formatting)
    sed -i -E "s/^(MASS_POINT[[:space:]]*=[[:space:]]*)[0-9]+(.*)$/\\1${MASS}\\2/" "${OUTFILE}"

    # 4) Optional but helpful: update FLAVOR string to match template choice
    sed -i -E "s/^(FLAVOR[[:space:]]*=[[:space:]]*)'[^']*'(.*)$/\\1'${FLAVOR_STR}'\\2/" "${OUTFILE}"

  done
done

echo "[done] Generated fragments inside:"
if [[ "${MODE}" == "gluinos" ]]; then
  echo "  ${BASE_DIR}/HSCPgluino_M-<MASS>_xqcut<XQCUT>/"
else
  echo "  ${BASE_DIR}/HSCPstop_M-<MASS>_xqcut<XQCUT>/"
fi
