#!/bin/sh

FILE="$1"

# extract first line
head -n 1 $FILE > ${FILE}.info

# delete first line
sed -i '1d' $FILE

# add labels/features separator
sed -i 's/\(,[0-9]*\) \([0-9]*:\)/\1 | \2/g' $FILE

# remove labels separators	
sed -i 's/,/ /g' $FILE

