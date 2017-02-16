#!/usr/bin/env bash

FILE="$1"

# get metadata
CLASSES=$(cat ${FILE} | cut -d ' ' -f 1 | sort | uniq | wc -l)
echo $CLASSES >> ${FILE}.classes
EXAMPLES=$(cat ${FILE} | wc -l)
echo $EXAMPLES >> ${FILE}.examples

echo "CONVERTING $FILE TO VW FORMAT ..."
echo "$EXAMPLES EXAMPLES, $CLASSES CLASSES"

# add labels/features separator
sed -i "s/\(\(^\|,\| \)[0-9]\+\)  *\([0-9]\+:\)/\1 | \3/g" $FILE

