#!/usr/bin/env bash

# usage:   ./initial-setup.sh <CMSSW_VERSION> <MIN_MASS> <MAX_MASS> <INCREMENT>
# example: ./initial-setup.sh CMSSW_13_2_9 1000 2000 100

set -euo pipefail

if [[ $# -ne 4 ]]; then
  echo "Usage: $0 <CMSSW_VERSION> <MIN_MASS> <MAX_MASS> <INCREMENT>"
  exit 1
fi

cmssw_version="$1"
min_mass="$2"
max_mass="$3"
incr="$4"

# 1) clone genproductions if needed
if [[ -d "genproductions" ]]; then
  echo "genproductions already exists."
else
  echo "genproductions not found. Cloning into $(pwd)/genproductions..."
  git clone git@github.com:cms-sw/genproductions.git
fi

# 2) ensure CMSSW_Releases parent exists and create release
parent_dir="CMSSW_Releases"
if [[ ! -d "${parent_dir}" ]]; then
  echo "${parent_dir} not found. Creating..."
  mkdir -pv "${parent_dir}"
fi

cmssw_base="${parent_dir}/${cmssw_version}"
if [[ -d "${cmssw_base}" ]]; then
  echo "${cmssw_version} already present under ${parent_dir}."
else
  echo "Creating CMSSW release ${cmssw_version} in ${parent_dir}..."
  pushd "${parent_dir}" > /dev/null
  cmsrel "${cmssw_version}"
  popd > /dev/null
  mkdir -pv "${cmssw_base}/src/Configuration/GenProduction/python/"
  echo "Created ${cmssw_version} and gen-prod python dir."
fi

# 3) top-level run_directories
run_root="run_directories"
mkdir -pv "${run_root}"

# 4) loop over mass range and make subdirectories
for m in $(seq "${min_mass}" "${incr}" "${max_mass}"); do
  dir="${run_root}/mg-Rhadron_mGl-${m}"
  if [[ -d "${dir}" ]]; then
    echo "Directory ${dir} already exists."
  else
    echo "Creating run directory ${dir}..."
    mkdir -pv "${dir}"
  fi

  for sub in input-cards input-configs output-configs scripts text-logs; do
    mkdir -pv "${dir}/${sub}"
  done
done

echo "All run directories created under ${run_root}."
