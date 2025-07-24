#!/usr/bin/env bash
set -euo pipefail

# Usage: ./run-gridpack.sh <RUN_NAME> <CMSSW_VERSION> <NEVENTS> <DEBUG_TAG>
# Example: ./run-gridpack.sh mg-Rhadron_mGl-1800 CMSSW_13_2_9 100 MYTAG

run="$1"
cmssw_version="${2:-}"
nevents="${3:-100}"
debug_tag="${4:-}"

fragment_type="Jet_matching_ON"

base_dir="$(pwd)"
run_dir="${base_dir}/${run}"
cmssw_base="/afs/cern.ch/user/a/avendras/work/CMSSW_Releases/${cmssw_version}"

# Paths fragment & custom commands
config_in_filename="${run}-fragment_${fragment_type}.py"
config_in_path="${run_dir}/input-configs/${config_in_filename}"
custom_commands_src="${run_dir}/input-configs/CustomCommands.py"
custom_commands_dst="${cmssw_base}/src/Configuration/GenProduction/python/CustomCommands.py"

# Make sure all directories exist
eos_base="/eos/user/a/avendras/gridpack_output/HSCP/${run}/root_files"
mkdir -p "${run_dir}/output-configs" "${run_dir}/text-logs" "${eos_base}"

# Output filenames
gen_cfg_name="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-GEN_cfg.py"
sim_cfg_name="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-SIM_cfg.py"
gen_cfg_path="${run_dir}/output-configs/${gen_cfg_name}"
sim_cfg_path="${run_dir}/output-configs/${sim_cfg_name}"
debug_out_filename="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-GEN-SIM.debug"
debug_out_path="${run_dir}/text-logs/${debug_out_filename}"
root_out_filename="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}"
root_out_path="${eos_base}/${root_out_filename}"

# Sanity checks 
if [[ -z "${cmssw_version}" ]]; then
  echo "ERROR: No CMSSW version declared. Exiting."
  exit 1
elif [[ ! -d "${cmssw_base}" ]]; then
  echo "ERROR: CMSSW release not found under ${cmssw_base}. Exiting."
  exit 1
elif [[ ! -f "${config_in_path}" ]]; then
  echo "ERROR: Fragment not found: ${config_in_path}. Exiting."
  exit 1
elif [[ ! -f "${custom_commands_src}" ]]; then
  echo "ERROR: CustomCommands.py not found at ${custom_commands_src}. Exiting."
  exit 1
fi

echo "[1/6] Copying fragment and CustomCommands into CMSSW area..."
cp -v "${config_in_path}" \
      "${cmssw_base}/src/Configuration/GenProduction/python/${config_in_filename}"
cp -v "${custom_commands_src}" "${custom_commands_dst}"

# Enter CMSSW
cd "${cmssw_base}"
echo "[2/6] Setting up CMSSW and building ..."
cmsenv
scram b -j8

# Step 1: LHE & GEN 
echo "[3/6] Phase 1: running LHE and GEN only"
cmsDriver.py Configuration/GenProduction/python/"${config_in_filename}" \
  --python_filename "${gen_cfg_path}" \
  --eventcontent RAWSIM,LHE \
  --step LHE,GEN \
  --datatier GEN,LHE \
  --fileout file:"${root_out_path}-GEN-ONLY.root" \
  --conditions   106X_upgrade2018_realistic_v4 \
  --beamspot     Realistic25ns13TeVEarly2018Collision \
  --geometry     DB:Extended \
  --era          Run2_2018 \
  --mc           -n "${nevents}" \
  --customise Configuration/DataProcessing/Utils.addMonitoring \
 --no_exec

cmsRun "${gen_cfg_path}"


# Install the produced pythia8 particle table 
echo "[4/6] Installing rhadron_pythia8.dat into CMSSW data area"
mkdir -p "${cmssw_base}/src/SimGeneral/HepPDTESSource/data/"
cp -v ${cmssw_base}/Pythia8_RhadronParticleDataTable.dat \
      "${cmssw_base}/src/SimGeneral/HepPDTESSource/data/Pythia8_RhadronParticleDataTable.dat"

# Step 2: SIM only 
echo "[5/6] Phase 2: running SIM with custom .dat"
cmsDriver.py Configuration/GenProduction/python/"${config_in_filename}" \
  --python_filename "${sim_cfg_path}" \
  --eventcontent FEVTDEBUG \
  --step SIM \
  --filein  file:"${root_out_path}-GEN-ONLY.root" \
  --fileout file:"${root_out_path}-SIM.root" \
  --conditions   106X_upgrade2018_realistic_v4 \
  --beamspot     Realistic25ns13TeVEarly2018Collision \
  --geometry     DB:Extended \
  --era          Run2_2018 \
  --mc \
  --customise Configuration/DataProcessing/Utils.addMonitoring \
  --customise Configuration/GenProduction/CustomCommands.addCustomisation \
  --no_exec

cmsRun "${sim_cfg_path}" 2>&1 | tee "${debug_out_path}"

cd - >/dev/null
echo "[6/6] Finished. GEN-SIM output at: ${root_out_path}"
