#!/bin/bash
# Check that the user provided the correct number of arguments.
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <CMSSW_VERSION> <RUN> <nEvents>"
    exit 1
fi

CMSSW_VERSION="$1"
RUN="$2"
nEvents="$3"

for xqcut in {60..100..10}; do
    echo "------------------------------------------"
    echo "Running auto_generate_gridpack.sh with xqcut = ${xqcut}"
    echo ""  
    echo ""  

    
    # Execute the command
    ./auto_generate_gridpack.sh "${CMSSW_VERSION}" "${RUN}" "${nEvents}" "${xqcut}"

    echo "" 
    echo "Sleeping for 1min before next iteration..."
    sleep 60
    echo ""  
done