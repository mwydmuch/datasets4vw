#!/usr/bin/env bash

FILE="$1"

echo "CONVERTING $FILE TO VW FORMAT ..."
echo "${INFOARRAY[0]} EXAMPLES, ${INFOARRAY[1]} FEATURES, ${INFOARRAY[2]} LABELS"

# extract metadata
INFO=$(head -n 1 $FILE)
INFOARRAY=($INFO)
echo ${INFOARRAY[0]} > ${FILE}.examples
echo ${INFOARRAY[1]} > ${FILE}.features
echo ${INFOARRAY[2]} > ${FILE}.labels



# delete first line
sed -i '1d' $FILE

# add labels/features separator
sed -i "s/\(\(^\|,\| \)[0-9][0-9]*\)  *\([0-9][0-9]*:\)/\1 | \3/g" $FILE

# replace 0 with the highest label
sed -i "s/^0,\(.*\) |/\1 ${INFOARRAY[2]} |/g" $FILE

# remove labels separators	
sed -i 's/,/ /g' $FILE
