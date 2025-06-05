#!/usr/bin/bash

run=$1
cmssw_version="${2:-}"
nevents="${3:-100}"
debug_tag="${4:-}"
fragment_type="Jet_matching_ON"

# Define base paths
eos_base="/eos/home-a/avendras/mg-Rhadron_v6"
work_dir="${eos_base}/${run}"
input_configs="${work_dir}/input-configs"
output_configs="${work_dir}/output-configs"
root_files="${work_dir}/root-files"
text_logs="${work_dir}/text-logs"

# Ensure required directories exist
mkdir -p "$output_configs" "$root_files" "$text_logs"

config_in_filename="${run}-fragment_${fragment_type}.py"
config_in_path="${input_configs}/${config_in_filename}"
config_out_filename="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-1_cfg.py"
root_out_filename="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}.root"
debug_out_filename="${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}.debug"

echo "Storing log file in $text_logs/$debug_out_filename"
echo "Copying $config_in_path to $cmssw_version/src/Configuration/GenProduction/python/"
cp -v "$config_in_path" "$cmssw_version/src/Configuration/GenProduction/python/"

if grep -Fq "$cmssw_version" "$cmssw_version/src/Configuration/GenProduction/python/$config_in_filename"; then
    echo "Gridpack CMSSW version matches declared CMSSW version."
else
    echo "Gridpack CMSSW version does not match declared CMSSW version. Exiting."
    exit 1
fi

genStart() {
    cd "$cmssw_version"
    echo "Setting up cmsenv"
    cmsenv
    echo "Scram step"
    scram b

    nohup cmsDriver.py Configuration/GenProduction/python/$config_in_filename \
        --python_filename "${output_configs}/${config_out_filename}" \
        --eventcontent RAWSIM,LHE \
        --customise Configuration/DataProcessing/Utils.addMonitoring \
        --customise_commands "\
            process.load('IOMC.RandomEngine.IOMC_cff'); \
            process.RandomNumberGeneratorService.generator.initialSeed = cms.untracked.uint32(123456789); \
            process.RandomNumberGeneratorService.g4SimHits.initialSeed = cms.untracked.uint32(987654321); \
            process.RandomNumberGeneratorService.VtxSmeared.initialSeed = cms.untracked.uint32(192837465); \
            process.rndmStore = cms.EDProducer('RandomEngineStateProducer')" \
        --datatier GEN,LHE \
        --fileout file:${root_files}/${root_out_filename} \
        --conditions 106X_upgrade2018_realistic_v4 \
        --beamspot Realistic25ns13TeVEarly2018Collision \
        --step LHE,GEN \
        --geometry DB:Extended \
        --era Run2_2018 \
        --mc -n $nevents \
        2>&1 | tee "${text_logs}/${debug_out_filename}"
    cd ..
}

genStart


#run=$1
#cmssw_version="${2:-}"
#nevents="${3:-100}"
#debug_tag="${4:-}"
#parent_dir_name=$(basename "$PWD")
#
#fragment_type="Jet_matching_ON"
#
#config_in_filename="${run}-fragment_${fragment_type}.py"
#
#if [[ $cmssw_version == "" ]]; then
#    echo "No CMSSW version declared. Exiting"
#    exit 1
#elif [[ ! -z $(ls | grep "$cmssw_version") ]]; then
#    echo "Declared CMSSW version $cmssw_version installed."
#else
#    echo "Declared CMSSW version $cmssw_version not found. Exiting."
#    exit 1
#fi
#
#config_out_filename="$run/output-configs/$run-$cmssw_version-n$nevents-$fragment_type-$debug_tag-1_cfg.py"
#root_out_filename="$run/root-files/$run-$cmssw_version-n$nevents-$fragment_type-$debug_tag.root"
#debug_out_filename="$run/text-logs/$run-$cmssw_version-n$nevents-$fragment_type-$debug_tag.debug"
#
#echo "Storing log file in $debug_out_filename"
#echo "Copying $config_in_filename from $run/input-configs/ to src/Configuration/GenProduction/python/"
#cp -v $run/input-configs/$config_in_filename $cmssw_version/src/Configuration/GenProduction/python/
#
#if [[ ! -z $(grep -F "$cmssw_version" "$cmssw_version/src/Configuration/GenProduction/python/$config_in_filename") ]]; then
#    echo "Gridpack CMSSW version matches declared CMSSW version."
#else
#    echo "Gridpack CMSSW version does not match declared CMSSW version. Exiting."
#    exit 1
#fi
#
#genStart() {
#    cd $cmssw_version
#    echo "Setting up cmsenv"
#    cmsenv
#    echo "Scram step"
#    scram b
#
#    # Inline the random seed settings using --customise_commands
#    nohup cmsDriver.py Configuration/GenProduction/python/$config_in_filename \
#        --python_filename ../$config_out_filename \
#        --eventcontent RAWSIM,LHE \
#        --customise Configuration/DataProcessing/Utils.addMonitoring \
#        --customise_commands "\
#			process.load('IOMC.RandomEngine.IOMC_cff'); \
#			process.RandomNumberGeneratorService.generator.initialSeed = cms.untracked.uint32(123456789); \
#			process.RandomNumberGeneratorService.g4SimHits.initialSeed = cms.untracked.uint32(987654321); \
#			process.RandomNumberGeneratorService.VtxSmeared.initialSeed = cms.untracked.uint32(192837465); \
#			process.rndmStore = cms.EDProducer('RandomEngineStateProducer')" \
#        --datatier GEN,LHE \
#        --fileout file:../$root_out_filename \
#        --conditions 106X_upgrade2018_realistic_v4 \
#        --beamspot Realistic25ns13TeVEarly2018Collision \
#        --step LHE,GEN \
#        --geometry DB:Extended \
#        --era Run2_2018 \
#        --mc -n $nevents \
#        2>&1 | tee ../$debug_out_filename
#    cd ..
#}
#
#genStart
#