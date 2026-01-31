#!/bin/bash

# Mass points for gluinos. Edit to desired mass points for card & dir generation
MASSES="1000 1100 1200 1300 1400 1500 1600 1800 2000 2200 2400 2600"
XQCUTS="10 20 40 60 80 100 110 120 130 140 150 160 170"

BASE_DIR="gluino-based"
mkdir -p "${BASE_DIR}"

for MASS in ${MASSES}; do
  for XQCUT in ${XQCUTS}; do

    XQCUT_TAG="xqcut${XQCUT}"

    BASE_NAME="HSCPgluino_M-${MASS}"
    NAME="${BASE_NAME}_${XQCUT_TAG}"
    DIR="${BASE_DIR}/${NAME}"

    mkdir -p "${DIR}"
    cp HSCPgluinoTemplate_param_card.dat "${DIR}/${NAME}_param_card.dat"
    cp HSCPgluinoTemplate_run_card.dat   "${DIR}/${NAME}_run_card.dat"
    cp HSCPgluinoTemplate_proc_card.dat  "${DIR}/${NAME}_proc_card.dat"

    MASS_SCI=$(printf "%1.6e" "${MASS}")
    sed -i -E "s/^( *1000021 +)[0-9.eE+-]+( +# mgo.*)/\1${MASS_SCI}\2/" "${DIR}/${NAME}_param_card.dat"
    sed -i -E "s/^output[[:space:]]+HSCPgluinoTemplate.*$/output ${NAME} -nojpeg/" "${DIR}/${NAME}_proc_card.dat"

    RUN_CARD="${DIR}/${NAME}_run_card.dat"

    sed -i "s/^.*= run_tag ! name of the run/${NAME} = run_tag ! name of the run/" "${RUN_CARD}"
    sed -i -E "s/^[[:space:]]*100[[:space:]]*=[[:space:]]*ptj/ ${XQCUT} = ptj/" "${RUN_CARD}"
    sed -i -E "s/^[[:space:]]*100[[:space:]]*=[[:space:]]*ptb/ ${XQCUT} = ptb/" "${RUN_CARD}"
    sed -i -E "s/^[[:space:]]*100[[:space:]]*=[[:space:]]*xqcut/ ${XQCUT}   = xqcut/" "${RUN_CARD}"

  done
done
