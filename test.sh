#!/bin/bash
# Usage: ./automation.sh CMSSW_VERSION RUN nEvents xqcut

# Check if required arguments are provided
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 CMSSW_VERSION RUN nEvents xqcut"
  exit 1
fi

# 1. Define variables
CMSSW_VERSION="$1"
RUN="$2"
nEvents="$3"
xqcut="$4"

# 2. Run the initial setup script with CMSSW_VERSION and RUN
bash initial-setup.sh "$CMSSW_VERSION" "$RUN"
if [ $? -ne 0 ]; then
  echo "Error: initial-setup.sh failed"
  exit 1
fi

# 3. Change directory to genproductions/bin/MadGraph5_aMCatNLO/
cd genproductions/bin/MadGraph5_aMCatNLO/ || { echo "Directory not found"; exit 1; }
echo "Cleaning MadGraph5_aMCatNLO directory" 
rm -rf $RUN
# 4. Edit specific .py and input_card.dat files
# Debug: Print current working directory
echo "Current working directory: $(pwd)"

# Define the path to the run card file relative to the current directory
#!/bin/bash

# Define the run card file path
RUN_CARD_FILE="../../../${RUN}/input-cards/${RUN}_run_card.dat"
echo "Looking for run card file at: ${RUN_CARD_FILE}"

# Define the fragment file (place this before using it)
FRAGMENT_FILE="../../../${RUN}/input-configs/${RUN}-fragment_Jet_matching_ON.py"

# Check if the run card file exists
if [ ! -f "${RUN_CARD_FILE}" ]; then
  echo "Error: Run card file not found at ${RUN_CARD_FILE}"
  echo "Listing contents of ../../../${RUN}/input-cards/:"
  ls -l "../../../${RUN}/input-cards/"
  exit 1
fi

# Check if the fragment file exists
if [ ! -f "${FRAGMENT_FILE}" ]; then
  echo "Error: Fragment file not found at ${FRAGMENT_FILE}"
  exit 1
fi

# Update xqcut in the run card file
sed -i -E "s/^([[:space:]]*)[0-9.]+(\s*=\s*xqcut\s*!.*)/${xqcut}\2/" "${RUN_CARD_FILE}"
echo "xqcut set to ${xqcut} in run card."

# Propagate the xqcut value to the fragment file as qCut
sed -i -E "s/(JetMatching:qCut\s*=\s*)[0-9.]+/\1${xqcut}/" "${FRAGMENT_FILE}"
echo "qCut set to ${xqcut} in fragment."

# Extract maxjetflavor from the run card file
maxjetflavor=$(grep -oP '^\s*\d+\s*=\s*maxjetflavor' "${RUN_CARD_FILE}" | awk '{print $1}')

# Debug: Check if extraction was successful
if [ -z "${maxjetflavor}" ]; then
  echo "Warning: No maxjetflavor value extracted from run card. Please verify the pattern and file contents."
else
  echo "Extracted maxjetflavor from run card: ${maxjetflavor}."
fi

# Update the fragment file by setting JetMatching:nQmatch to maxjetflavor
sed -i -E "s/(JetMatching:nQmatch\s*=\s*)[0-9]*/\1${maxjetflavor}/" "${FRAGMENT_FILE}"
echo "JetMatching:nQmatch set to ${maxjetflavor} in fragment."


## 5. Run gridpack_generation.sh with RUN and the input-cards directory
./gridpack_generation.sh "$RUN" "../../../${RUN}/input-cards/"
if [ $? -ne 0 ]; then
  echo "Error: gridpack_generation.sh failed"
  exit 1
fi

# 6. gridpack_generation.sh produces a tar file and a ${RUN}.log file.
#    Assume the tar file is named ${RUN}.tar (adjust if needed)
TARFILE="${RUN}.tar"

# 7. Move the tar file to the input-configs directory
INPUT_CONFIG_DIR="../../../${RUN}/input-configs"
if [ ! -d "$INPUT_CONFIG_DIR" ]; then
  echo "Creating input-configs directory at $INPUT_CONFIG_DIR"
  mkdir -p "$INPUT_CONFIG_DIR"
fi

# Check if a tar file already exists in INPUT_CONFIG_DIR and delete it
if ls "$INPUT_CONFIG_DIR"/*.tar &> /dev/null; then
  echo "Removing existing tar file(s) in $INPUT_CONFIG_DIR..."
  rm -f "$INPUT_CONFIG_DIR"/*.tar
fi

# Move the new tar file if it exists
if [ -f "$TARFILE" ]; then
  mv "$TARFILE" "$INPUT_CONFIG_DIR/"
  echo "Moved $TARFILE to $INPUT_CONFIG_DIR/"
else
  echo "Error: Tar file $TARFILE not found"
  exit 1
fi

# 8. Untar the tar file into a directory called extracted_tar (inside input-configs)
EXTRACT_DIR="${INPUT_CONFIG_DIR}/extracted_tar"
mkdir -p "$EXTRACT_DIR"
sleep 2
tar -xvaf "${INPUT_CONFIG_DIR}/${TARFILE}" -C "$EXTRACT_DIR"
if [ $? -ne 0 ]; then
  echo "Error: Failed to untar $TARFILE"
  exit 1
fi

# 9. Change directory back to the main directory and set up the CMS environment
cd ../../../ || { echo "Failed to cd back to main directory"; exit 1; }
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc7_amd64_gcc700

# 10. Run the run-gridpack.sh script with CMSSW_VERSION, RUN, and nEvents
bash run-gridpack.sh "$CMSSW_VERSION" "$RUN" "$nEvents"
if [ $? -ne 0 ]; then
  echo "Error: run-gridpack.sh failed"
  exit 1
fi

echo "Automation complete."
