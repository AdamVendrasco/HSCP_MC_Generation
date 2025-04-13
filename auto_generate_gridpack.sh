#!/bin/bash
set -e

###############################################################################
#                                Variables Setup                              #
###############################################################################
CMSSW_VERSION="$1"
RUN="$2"
nEvents="$3"
xqcut="$4"

BASE_DIR="${PWD}"
MG_DIR="${BASE_DIR}/genproductions/bin/MadGraph5_aMCatNLO"
RUN_DIR="${BASE_DIR}/${RUN}"
INPUT_CONFIGS_DIR="${RUN_DIR}/input-configs"
INPUT_CARDS_DIR="${RUN_DIR}/input-cards"
TEMPLATES_DIR="/eos/user/a/avendras/templates/${RUN}/fragments"

###############################################################################
#                           Cleanup Previous Run Data                         #
#####################s##########################################################
TARGET_DIR="${MG_DIR}/${RUN}"
if [ -d "${TARGET_DIR}" ]; then
  echo "Cleaning ${TARGET_DIR} directory"
  rm -rf "${TARGET_DIR}"
fi

if [ ! -d "${TARGET_DIR}" ]; then
  echo "Recreating the directory ${TARGET_DIR}"
  mkdir -p "${TARGET_DIR}"
else
  echo "Directory ${TARGET_DIR} already exists."
fi


###############################################################################
#                      Step 1: Initial Setup Invocation                       #
###############################################################################
echo "Running initial setup with CMSSW version ${CMSSW_VERSION} and run directory ${RUN}"
bash ./initial-setup.sh "${CMSSW_VERSION}" "${RUN}"

###############################################################################
#                     Step 2: Prepare Input Configuration                     #
###############################################################################
# Ensure input-configs directory exists.
if [ ! -d "${INPUT_CONFIGS_DIR}" ]; then
  mkdir -p "${INPUT_CONFIGS_DIR}"
fi

# Copy .py fragments to input-configs if they are not already present.
for file in "${TEMPLATES_DIR}"/*.py; do
  dest_file="${INPUT_CONFIGS_DIR}/$(basename "$file")"
  if [ ! -f "${dest_file}" ]; then
    cp "$file" "${INPUT_CONFIGS_DIR}/"
  fi
done

###############################################################################
#       Step 3: Update Run Card and Fragment with Provided Parameters         #
###############################################################################
RUN_CARD_FILE="${INPUT_CARDS_DIR}/${RUN}_run_card.dat"
FRAGMENT_FILE="${INPUT_CONFIGS_DIR}/${RUN}-fragment_Jet_matching_ON.py"

# Function to update numeric parameters in the run card.
update_run_card_param() {
  local param_value=$1
  local param_name=$2
  sed -i -E "s/^[[:space:]]*[0-9]+([[:space:]]+=[[:space:]]+${param_name}[[:space:]]+!.*)/${param_value}\1/" "${RUN_CARD_FILE}"
  echo "${param_name} set to ${param_value} in run card."
}

#Update run card parameters.
update_run_card_param "${nEvents}" "nevents"
update_run_card_param "${xqcut}" "xqcut"
update_run_card_param "${xqcut}" "ptj"
update_run_card_param "${xqcut}" "ptb"

# Update JetMatching:qCut in the fragment file.
sed -i -E "s/(JetMatching:qCut\s*=\s*)[0-9]+/\1${xqcut}/" "${FRAGMENT_FILE}"
echo "Updated JetMatching:qCut in fragment to ${xqcut}."

# The following block updates JetMatching:nQmatch.
# Commenting out to prevent updating it.
 maxjetflavor=$(grep -oP '^\s*\d+\s*=\s*maxjetflavor' "${RUN_CARD_FILE}" | awk '{print $1}')
 echo "Extracted maxjetflavor from run card: ${maxjetflavor}."
 sed -i -E "s/JetMatching:nQmatch\s*=\s*[0-9]+/JetMatching:nQmatch = ${maxjetflavor}/" "${FRAGMENT_FILE}"
 echo "JetMatching:nQmatch set to ${maxjetflavor} in fragment."

# The following block updates JetMatching:clFact.
# Commenting out to prevent updating it.
 alpsfact=$(grep -oP '^\s*\d+\s*=\s*alpsfact' "${RUN_CARD_FILE}" | awk '{print $1}')
 echo "Extracted alpsfact from run card: ${alpsfact}."
 
 #Remove any existing JetMatching:clFact and append new one.
 sed -i -E '/JetMatching:clFact/d' "${FRAGMENT_FILE}"
 sed -i "/JetMatching:qCut/a \\
             'JetMatching:clFact = ${alpsfact}', # determines jet-to parton matching" "${FRAGMENT_FILE}"
 echo "JetMatching:clFact set to ${alpsfact} in fragment."

###############################################################################
#                       Step 4: Gridpack Generation and Move                  #
###############################################################################
echo "Generating gridpack from cards in ${INPUT_CARDS_DIR}"
cd "${MG_DIR}"
(./gridpack_generation.sh "${RUN}" "../../../${RUN}/input-cards") || true

echo "Searching for the gridpack tarball..."
GRIDPACK=$(find . -maxdepth 1 -type f -name "${RUN}*.tar.xz" | head -n 1)
FULL_PATH=$(cd "$(dirname "$GRIDPACK")" && pwd)/$(basename "$GRIDPACK")
echo "Found gridpack tarball at: ${FULL_PATH}"

echo "Moving gridpack tarball to: ${INPUT_CONFIGS_DIR}"
echo "GRIDPACK: $GRIDPACK"
mv "${GRIDPACK}" "../../../${RUN}/input-configs/"
cd "../../../${RUN}/" || exit 1

###############################################################################
#                        Step 5: Extracting the Gridpack                       #
###############################################################################
EXTRACT_DIR="${INPUT_CONFIGS_DIR}/extracted_tar"

if [ ! -d "${EXTRACT_DIR}" ]; then
  echo "Directory 'extracted_tar/' does not exist. Creating it..."
  mkdir -vp "${EXTRACT_DIR}"
else
  echo "Directory 'extracted_tar/' already exists. Cleaning its contents..."
  rm -rf "${EXTRACT_DIR:?}"/*
fi

echo "Unpacking tarball into 'extracted_tar/'..."
cd "${INPUT_CONFIGS_DIR}"
tar -xavf "$(basename "$GRIDPACK")" -C "extracted_tar/"
cd "${BASE_DIR}"

###############################################################################
#                   Final Steps: Cleanup and Run Gridpack Script              #
###############################################################################
echo -e "\nGeneration complete. To run the gridpack, execute:\n"
echo "bash run-gridpack.sh <CMSSW-VERSION> <RUN> <nEvents> <debug_tag>"

echo "Cleaning up directories for the next run..."
rm -rf "${MG_DIR}/${RUN}"*
rm -rf "${INPUT_CONFIGS_DIR}"/*.tar

echo "Running run-gridpack.sh..."
bash ./run-gridpack.sh "${CMSSW_VERSION}" "${RUN}" "${nEvents}"
