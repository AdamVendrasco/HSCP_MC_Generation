#! /bin/bash

# Mass points for stops. Edit to desired mass points for card & dir generation
MASSES="700 800 900 1000 1200 1400 1600 1800 2000 2200 2400 2600"
XQCUTS="10 20 40 60 80 100 110 120 130 140 150 160 170"

BASE_DIR="stop-based"   
mkdir -p "${BASE_DIR}"

for MASS in ${MASSES}; do
  for XQCUT in ${XQCUTS}; do

    XQCUT_TAG="xqcut${XQCUT}"

    BASE_NAME="HSCPstop_M-${MASS}"
    NAME="${BASE_NAME}_${XQCUT_TAG}"
    DIR="${BASE_DIR}/${NAME}"

    mkdir -p "${DIR}"
    cp HSCPstopTemplate_param_card.dat "${DIR}/${NAME}_param_card.dat"
    cp HSCPstopTemplate_run_card.dat   "${DIR}/${NAME}_run_card.dat"
    cp HSCPstopTemplate_proc_card.dat  "${DIR}/${NAME}_proc_card.dat"

    MASS_SCI=$(printf "%1.6e" "${MASS}")
    sed -i "s/1000006 2.000000e+03 # msu3  1000006 ->stop/1000006 ${MASS_SCI} # msu3  1000006 ->stop/" "${DIR}/${NAME}_param_card.dat"
    sed -i "s/^output .*-nojpeg$/output ${NAME} -nojpeg/" "${DIR}/${NAME}_proc_card.dat"

    RUN_CARD="${DIR}/${NAME}_run_card.dat"

    sed -i "s/^ *tag_1 *= *.*/${NAME} = run_tag ! name of the run/" "${RUN_CARD}"
    sed -i -E "s/^[[:space:]]*150[[:space:]]*=[[:space:]]*ptj/ ${XQCUT} = ptj/" "${RUN_CARD}"
    sed -i -E "s/^[[:space:]]*150[[:space:]]*=[[:space:]]*ptb/ ${XQCUT} = ptb/" "${RUN_CARD}"
    sed -i -E "s/^[[:space:]]*150[[:space:]]*=[[:space:]]*xqcut/ ${XQCUT}   = xqcut/" "${RUN_CARD}"

  done
done
