#!/usr/bin/env bash

DATASET="$1"
SPLIT="$2"
OUTFILE="$3"

echo "SPLITING $1 USING $2 TO $3 ..."

if [ ! -e fast_split ]
then
    g++ fast_split.cpp -std=c++11 -o fast_split
fi

./fast_split $DATASET $SPLIT $OUTFILE

# OLD SLOW SPLIT
#echo "" > $OUTFILE
#
#while read L; do
#  sed "${L}q;d" $DATASET >> $OUTFILE
#done < $SPLIT

