#!/usr/bin/env bash

# usage:   ./run_gridpack.sh <RUN_NAME> <CMSSW_VERSION> <NEVENTS> <DEBUG_TAG>
# example: ./run_gridpack.sh mg-Rhadron_mGl-1800 CMSSW_13_2_9 20000 seeded_withFilter_20k

set -euo pipefail

run="$1"
cmssw_version="${2:-}"
nevents="${3:-100}"
debug_tag="${4:-}"

fragment_type="Jet_matching_ON"

# Paths (assuming this script lives in /afs/cern.ch/user/a/avendras/work/mg-Rhadron)
base_dir="$(pwd)"
cmssw_base="${base_dir}/CMSSW_Releases/${cmssw_version}"
run_dir="${base_dir}/${run}"

config_in_filename="${run}-fragment_${fragment_type}.py"
config_in_path="${run_dir}/input-configs/${config_in_filename}"

config_out_filename="${run}-""${cmssw_version}""-n""${nevents}""-""${fragment_type}""-""${debug_tag}""-1_cfg.py"
config_out_path="${run_dir}/output-configs/${config_out_filename}"


debug_out_filename="${run}-""${cmssw_version}""-n""${nevents}""-""${fragment_type}""-""${debug_tag}"".debug"
debug_out_path="${run_dir}/text-logs/${debug_out_filename}"

# EOS output path for root file (based on run name)
eos_base="/eos/user/a/avendras/root_files/HSCP/${run}"
root_out_filename="${run}-""${cmssw_version}""-n""${nevents}""-""${fragment_type}""-""${debug_tag}"".root"
root_out_path="${eos_base}/${root_out_filename}"

mkdir -p "${eos_base}"

if [[ -z "${cmssw_version}" ]]; then
    echo "ERROR: No CMSSW version declared. Exiting."
    exit 1
elif [[ -d "${cmssw_base}" ]]; then
    echo "CMSSW release found at ${cmssw_base}."
else
    echo "ERROR: CMSSW release not found under ../CMSSW_Releases/${cmssw_version}. Exiting."
    exit 1
fi

if [[ ! -f "${config_in_path}" ]]; then
    echo "ERROR: Input file not found: ${config_in_path}. Exiting."
    exit 1
fi

echo "Storing log file in ${debug_out_path}"
echo "Copying ${config_in_filename} from input-configs to CMSSW area..."
cp -v "${config_in_path}" "${cmssw_base}/src/Configuration/GenProduction/python/"


if grep -Fq "${cmssw_version}" "${cmssw_base}/src/Configuration/GenProduction/python/${config_in_filename}"; then
    echo "Fragment's CMSSW version matches ${cmssw_version}."
else
    echo "ERROR: Fragment CMSSW version mismatch. Exiting."
    exit 1
fi

genStart() {
    cd "${cmssw_base}"
    echo "Setting up cmsenv in ${cmssw_base}"
    cmsenv
    echo "Checking for project rename..."
    scramv1 b ProjectRename || true
    echo "Building CMSSW project"
    scram b -j8

    echo "Running cmsDriver to produce LHE/GEN..."
    nohup cmsDriver.py \
        Configuration/GenProduction/python/${config_in_filename} \
        --python_filename ${config_out_path} \
        --eventcontent RAWSIM,LHE \
        --customise Configuration/DataProcessing/Utils.addMonitoring \
        --customise_commands "\
            process.load('IOMC.RandomEngine.IOMC_cff'); \
            process.RandomNumberGeneratorService.generator.initialSeed = cms.untracked.uint32(123456789); \
            process.RandomNumberGeneratorService.g4SimHits.initialSeed = cms.untracked.uint32(987654321); \
            process.RandomNumberGeneratorService.VtxSmeared.initialSeed = cms.untracked.uint32(192837465); \
            process.rndmStore = cms.EDProducer('RandomEngineStateProducer')" \
        --datatier GEN,LHE \
        --fileout file:${root_out_path} \
        --conditions 106X_upgrade2018_realistic_v4 \
        --beamspot Realistic25ns13TeVEarly2018Collision \
        --step LHE,GEN \
        --geometry DB:Extended \
        --era Run2_2018 \
        --mc -n ${nevents} \
        2>&1 | tee ${debug_out_path}

    cd - >/dev/null
}

# Execute the generation
genStart
