#!/usr/bin/env bash

DATASET="$1"
SPLIT="$2"
OUTFILE="$3"
SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )

echo "SPLITTING $1 USING $2 TO $3 ..."

if [ ! -e fast_split ]; then
    g++ ${SCRIPT_DIR}/fast_split.cpp -std=c++11 -O2 -o ${SCRIPT_DIR}/fast_split
fi

${SCRIPT_DIR}/fast_split $DATASET $SPLIT $OUTFILE

# SLOW BASH SPLIT
# SPLITS=$(seq 0 9)
# for split in ${SPLITS[@]}; do
#     FIELD=$(expr ${split} + 1)
#     LINES=$(cat ${SPLIT} | cut -d " " -f${FIELD})
#     rm -f ${OUTFILE}${split}
#     for line in ${LINES[@]}; do
#         sed -n "${line}p" ${DATASET} >> ${OUTFILE}${split}
#     done
# done
