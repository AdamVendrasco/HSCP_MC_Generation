#!/usr/bin/env bash

# usage:   ./initial-setup.sh <CMSSW_VERSION> <RUN_NAME>
# example: ./initial-setup.sh CMSSW_13_2_9 mg-Rhadron_mGl-1800

set -euo pipefail

cmssw_version="$1"
run="$2"

# checks/clones genproductions in the current directory
if [[ -d "genproductions" ]]; then
    echo "genproductions already exists."
else
    echo "genproductions not found. Cloning into $(pwd)/genproductions..."
    git clone git@github.com:cms-sw/genproductions.git
fi

# checks/creates the CMSSW release is under ../CMSSW_Releases/
cmssw_base="../CMSSW_Releases/${cmssw_version}"
if [[ -d "${cmssw_base}" ]]; then
    echo "${cmssw_version} already present under ../CMSSW_Releases/."
else
    echo "${cmssw_version} not found under ../CMSSW_Releases/. Creating..."
    cd ../CMSSW_Releases
    cmsrel "${cmssw_version}"
    cd - >/dev/null
    echo "Created ${cmssw_version}. Now creating Configuration/GenProduction/python/…"
    mkdir -pv "${cmssw_base}/src/Configuration/GenProduction/python/"
fi

# checks/creates that the run directory in the current folder
if [[ -d "${run}" ]]; then
    echo "Run directory '${run}' already exists. Ensuring subfolders exist…"
else
    echo "Creating run directory '${run}'…"
    mkdir -v "${run}"
fi

# creates the four subdirectories under <RUN_NAME>/ dir
for sub in input-cards input-configs output-configs text-logs; do
    if [[ -d "${run}/${sub}" ]]; then
        echo "'${run}/${sub}' already exists."
    else
        echo " Creating '${run}/${sub}'"
        mkdir -v "${run}/${sub}"
    fi
done

echo "Setup complete."
