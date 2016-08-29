#!/bin/sh

DATASET="$1"
SPLIT="$2"
OUTFILE="$3"

echo "SPLITING $1 USING $2 TO $3"

echo "" > $OUTFILE

while read L; do
  sed "${L}q;d" $DATASET >> $OUTFILE
done < $SPLIT
