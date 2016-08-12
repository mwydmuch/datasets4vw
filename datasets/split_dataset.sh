#!/bin/sh

DATASET="$1"
SPLIT="$2"
OUTFILE="$3"

rm $OUTFILE

while read L; do
  sed "${L}q;d" $DATASET >> $OUTFILE
done < $SPLIT
