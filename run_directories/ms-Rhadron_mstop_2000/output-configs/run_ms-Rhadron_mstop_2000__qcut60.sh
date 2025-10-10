#!/usr/bin/env bash
set -euo pipefail
cd /uscms/home/avendras/nobackup/HSCP
export FRAGMENT_NAME="ms-Rhadron_mstop_2000-fragment_Jet_matching_ON__qcut60.py"
./run-gridpack_GEN-SIM.sh ms-Rhadron_mstop_2000 CMSSW_10_6_47 100 qcut60
