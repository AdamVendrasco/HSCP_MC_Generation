#!/usr/bin/env bash
set -euo pipefail

# Usage: ./run-nanogen.sh <RUN_NAME> <CMSSW_VERSION> [NEVENTS] [DEBUG_TAG]
run="$1"
cmssw_version="$2"
nevents="${3:-100}"
debug_tag="${4:-}"

fragment_type="Jet_matching_ON"
base_runs="/uscms/home/avendras/nobackup/HSCP/run_directories"
run_dir="${base_runs}/${run}"
cmssw_base="/uscms/home/avendras/nobackup/HSCP/CMSSW_Releases/${cmssw_version}"

# ── inputs
config_in="${run_dir}/input-configs/${run}-fragment_${fragment_type}.py"
custom_commands_src="${run_dir}/input-configs/CustomCommands.py"

# ── outputs
out_dir="${run_dir}/output-configs"
log_dir="${run_dir}/text-logs"
root_dir="${run_dir}/root_files"
mkdir -p "${out_dir}" "${log_dir}" "${root_dir}"

nano_cfg="${out_dir}/${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-NANOGEN_cfg.py"
nano_root="${root_dir}/${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-NANOGEN.root"
debug_log="${log_dir}/${run}-${cmssw_version}-n${nevents}-${fragment_type}-${debug_tag}-NANOGEN.debug"

# ── Sanity
[[ -d "${cmssw_base}" ]] || { echo "ERROR: CMSSW area not found at ${cmssw_base}"; exit 1; }
[[ -f "${config_in}" ]]  || { echo "ERROR: Fragment missing at ${config_in}";  exit 1; }
[[ -f "${custom_commands_src}" ]] || { echo "ERROR: CustomCommands.py missing"; exit 1; }

cd "${cmssw_base}"

# ── 1) Copy fragment & CustomCommands in
echo "[1/4] Copying fragment and CustomCommands into CMSSW area..."
cp -v "${config_in}" \
   "${cmssw_base}/src/Configuration/GenProduction/python/$(basename ${config_in})"
cp -v "${custom_commands_src}" \
   "${cmssw_base}/src/Configuration/GenProduction/python/CustomCommands.py"

# ── 2) cmsenv & build
echo "[2/4] cmsenv & scram b -j8"
cmsenv
scram b -j8

# ── 3) LHE→GEN→NANOGEN
echo "[3/4] Running LHE→GEN→NANOGEN"
cmsDriver.py Configuration/GenProduction/python/"$(basename ${config_in})" \
  --python_filename "${nano_cfg}" \
  --eventcontent   NANOAODGEN \
  --step           LHE,GEN,NANOGEN \
  --datatier       NANOGEN \
  --fileout        file:"${nano_root}" \
  --conditions     106X_upgrade2018_realistic_v4 \
  --beamspot       Realistic25ns13TeVEarly2018Collision \
  --geometry       DB:Extended \
  --era            Run2_2018,run2_nanoAOD_106Xv2 \
  --mc \
  --customise      Configuration/DataProcessing/Utils.addMonitoring \
  --no_exec \
  -n "${nevents}"

cmsRun "${nano_cfg}" 2>&1 | tee "${debug_log}"

# ── 4) Done
cd - >/dev/null
echo "[4/4] Done."
echo "→ NanoGEN file: ${nano_root}"
echo "→ Log file:    ${debug_log}"
