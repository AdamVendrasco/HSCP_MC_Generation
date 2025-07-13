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
cmssw_base="/afs/cern.ch/user/a/avendras/work/CMSSW_Releases/${cmssw_version}"
run_dir="${base_dir}/${run}"

config_in_filename="${run}-fragment_${fragment_type}.py"
config_in_path="${run_dir}/input-configs/${config_in_filename}"

config_out_filename="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-GEN-SIM_cfg.py"
config_out_path="${run_dir}/output-configs/${config_out_filename}"

debug_out_filename="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-GEN-SIM.debug"
debug_out_path="${run_dir}/text-logs/${debug_out_filename}"

eos_base="/eos/user/a/avendras/gridpack_output/HSCP/${run}/root_files"
mkdir -p "${eos_base}"

gen_sim_out_filename="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-GEN-SIM.root"
root_out_path="${eos_base}/${gen_sim_out_filename}"

# Custom particle data table (for Geant4/HepPDTESSource)
custom_pdt_src="/afs/cern.ch/user/a/avendras/work/Pythia8_RhadronParticleDataTable.dat"
custom_pdt_name="Pythia8_RhadronParticleDataTable.dat"
custom_pdt_dest_rel="SimGeneral/HepPDTESSource/data/${custom_pdt_name}"

# --- SETUP ---

if [[ -z "${cmssw_version}" ]]; then
    echo "ERROR: No CMSSW version declared. Exiting."
    exit 1
elif [[ ! -d "${cmssw_base}" ]]; then
    echo "ERROR: CMSSW release not found under ${cmssw_base}. Exiting."
    exit 1
else
    echo "CMSSW release found at ${cmssw_base}."
fi

if [[ ! -f "${config_in_path}" ]]; then
    echo "ERROR: Input file not found: ${config_in_path}. Exiting."
    exit 1
fi

echo "Storing log file in ${debug_out_path}"

echo "Copying ${config_in_filename} from input-configs to CMSSW area..."
cp -v "${config_in_path}" "${cmssw_base}/src/Configuration/GenProduction/python/"

echo "Copying custom R-hadron particle data table to CMSSW area..."
mkdir -p "${cmssw_base}/src/SimGeneral/HepPDTESSource/data/"
cp -v "${custom_pdt_src}" "${cmssw_base}/src/${custom_pdt_dest_rel}"

# Optional: fragment version check
if grep -Fq "${cmssw_version}" "${cmssw_base}/src/Configuration/GenProduction/python/${config_in_filename}"; then
    echo "Fragment's CMSSW version matches ${cmssw_version}."
else
    echo "WARNING: Fragment CMSSW version not found in fragment. (This is sometimes normal for generic fragments.)"
fi

# --- MAIN FUNCTION ---
genSimStart() {
    cd "${cmssw_base}"
    echo "Setting up cmsenv in ${cmssw_base}"
    cmsenv
    echo "Checking for project rename..."
    scramv1 b ProjectRename || true
    echo "Building CMSSW project"
    scram b -j8

    echo "Running cmsDriver to produce GEN-SIM..."

    nohup cmsDriver.py Configuration/GenProduction/python/"${config_in_filename}" \
    --python_filename "${config_out_path}" \
    --eventcontent FEVTDEBUG,LHE \
    --customise Configuration/DataProcessing/Utils.addMonitoring,Configuration/GenProduction/CustomCommands.addCustomisation \
    --nThreads 1 \
    --datatier GEN-SIM,LHE \
    --fileout      "file:${root_out_path}" \
    --conditions   106X_upgrade2018_realistic_v4 \
    --beamspot     Realistic25ns13TeVEarly2018Collision \
    --step         LHE,GEN,SIM \
    --geometry     DB:Extended \
    --era          Run2_2018 \
    --mc           -n "${nevents}" \
    2>&1 | tee "${debug_out_path}"

    cd - >/dev/null
}

genSimStart

echo "GEN-SIM output is at: ${root_out_path}"
