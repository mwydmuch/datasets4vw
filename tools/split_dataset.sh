#!/usr/bin/env bash

DATASET="$1"
SPLIT="$2"
OUTFILE="$3"
SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )

echo "SPLITTING $1 USING $2 TO $3 ..."

if [ ! -e fast_split ]; then
    g++ ${SCRIPT_DIR}/fast_split.cpp -std=c++11 -o ${SCRIPT_DIR}/fast_split
fi

${SCRIPT_DIR}/fast_split $DATASET $SPLIT $OUTFILE

# Old (slow) split with sed
# echo "" > $OUTFILE
# while read L; do
#     sed "${L}q;d" $DATASET >> $OUTFILE
# done < $SPLIT
