#!/usr/bin/env bash
set -euo pipefail

# Usage: ./run-gridpack.sh <RUN_NAME> <CMSSW_VERSION> [NEVENTS] [DEBUG_TAG]
# Example: ./run-gridpack.sh mg-Rhadron_mGl-1800 CMSSW_13_2_9 100 MYTAG

run="$1"
cmssw_version="$2"
nevents="${3:-100}"
debug_tag="${4:-}"

fragment_type="Jet_matching_ON"

# ── where all your per-run folders live:
base_runs="/uscms/home/avendras/nobackup/HSCP/run_directories"
run_dir="${base_runs}/${run}"

# ── CMSSW area under HSCP/CMSSW_Releases
cmssw_base="/uscms/home/avendras/nobackup/HSCP/CMSSW_Releases/${cmssw_version}"

# ── inputs live under each run_dir/input-configs
config_in_filename="${run}-fragment_${fragment_type}.py"
config_in_path="${run_dir}/input-configs/${config_in_filename}"
custom_commands_src="${run_dir}/input-configs/CustomCommands.py"
custom_commands_dst="${cmssw_base}/src/Configuration/GenProduction/python/CustomCommands.py"

# ── outputs still go under run_dir
output_cfg_dir="${run_dir}/output-configs"
log_dir="${run_dir}/text-logs"
root_dir="${run_dir}/root_files"

mkdir -p "${output_cfg_dir}" "${log_dir}" "${root_dir}"

# ── sanity checks
if [[ -z "${cmssw_version}" ]]; then
  echo "ERROR: No CMSSW version declared. Exiting."
  exit 1
elif [[ ! -d "${cmssw_base}" ]]; then
  echo "ERROR: CMSSW not found under ${cmssw_base}. Exiting."
  exit 1
elif [[ ! -f "${config_in_path}" ]]; then
  echo "ERROR: Fragment not found: ${config_in_path}. Exiting."
  exit 1
elif [[ ! -f "${custom_commands_src}" ]]; then
  echo "ERROR: CustomCommands.py not found at ${custom_commands_src}. Exiting."
  exit 1
fi

# ── define filenames
gen_cfg_path="${output_cfg_dir}/${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-GEN_cfg.py"
sim_cfg_path="${output_cfg_dir}/${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-SIM_cfg.py"
debug_out="${log_dir}/${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-GEN-SIM.debug"
root_prefix="${root_dir}/${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}"

echo "[1/6] Copying fragment and CustomCommands into CMSSW area..."
cp -v "${config_in_path}" \
      "${cmssw_base}/src/Configuration/GenProduction/python/${config_in_filename}"
cp -v "${custom_commands_src}" "${custom_commands_dst}"

cd "${cmssw_base}"
echo "[2/6] cmsenv & build"
cmsenv
scram b -j8

echo "[3/6] Phase 1: LHE & GEN only"
cmsDriver.py Configuration/GenProduction/python/"${config_in_filename}" \
  --python_filename "${gen_cfg_path}" \
  --eventcontent RAWSIM,LHE \
  --step LHE,GEN \
  --datatier GEN,LHE \
  --fileout file:"${root_prefix}-GEN-ONLY.root" \
  --conditions   106X_upgrade2018_realistic_v4 \
  --beamspot     Realistic25ns13TeVEarly2018Collision \
  --geometry     DB:Extended \
  --era          Run2_2018 \
  --mc -n "${nevents}" \
  --customise Configuration/DataProcessing/Utils.addMonitoring \
  --no_exec

cmsRun "${gen_cfg_path}"

echo "[4/6] Installing Pythia8 table"
mkdir -p "${cmssw_base}/src/SimGeneral/HepPDTESSource/data/"
cp -v "${cmssw_base}/Pythia8_RhadronParticleDataTable.dat" \
      "${cmssw_base}/src/SimGeneral/HepPDTESSource/data/"

echo "[5/6] Phase 2: SIM only"
cmsDriver.py Configuration/GenProduction/python/"${config_in_filename}" \
  --python_filename "${sim_cfg_path}" \
  --eventcontent FEVTDEBUG \
  --step SIM \
  --filein  file:"${root_prefix}-GEN-ONLY.root" \
  --fileout file:"${root_prefix}-SIM.root" \
  --conditions   106X_upgrade2018_realistic_v4 \
  --beamspot     Realistic25ns13TeVEarly2018Collision \
  --geometry     DB:Extended \
  --era          Run2_2018 \
  --mc \
  --customise Configuration/DataProcessing/Utils.addMonitoring \
  --customise Configuration/GenProduction/CustomCommands.addCustomisation \
  --no_exec

cmsRun "${sim_cfg_path}" 2>&1 | tee "${debug_out}"

cd - >/dev/null
echo "[6/6] Done."
echo "      GEN → ${root_prefix}-GEN-ONLY.root"
echo "      SIM → ${root_prefix}-SIM.root"
