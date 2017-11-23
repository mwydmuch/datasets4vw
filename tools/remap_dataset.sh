#!/usr/bin/env bash

FILES="$1"
SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )

echo "REMAPPING $FILES ..."

if [ ! -e fast_remap ]; then
    g++ ${SCRIPT_DIR}/fast_remap.cpp -std=c++11 -O2 -o ${SCRIPT_DIR}/fast_remap
fi

${SCRIPT_DIR}/fast_remap $FILES
for file in ${FILES[@]}; do
    if [ -e ${file}.remapped ]; then
        mv ${file}.remapped ${file}
        rm ${file}.remapped
    fi
done
