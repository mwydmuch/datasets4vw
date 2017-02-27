#!/usr/bin/env bash

FILE="$1"

# get metadata
CLASSES=$(cat ${FILE} | grep -o "^[0-9]*\|,[0-9]*" | sed 's/,*//' | sort -g | uniq | wc -l)
echo $CLASSES >> ${FILE}.classes
EXAMPLES=$(cat ${FILE} | wc -l)
echo $EXAMPLES >> ${FILE}.examples

echo "CONVERTING $FILE TO VW FORMAT ..."
echo "$EXAMPLES EXAMPLES, $CLASSES CLASSES"

# add labels/features separatorcd 
sed -i "s/\(\(^\|,\| \)[0-9]\+\)  *\([0-9]\+:\)/\1 | \3/g" $FILE

# replace 0 with the highest label
#sed -i "s/^0[ ,]\(.*\)|/\1 $CLASSES |/g" $FILE

# replace comas with spaces	
sed -i 's/,/ /g' $FILE

