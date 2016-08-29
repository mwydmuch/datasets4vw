#!/bin/sh

FILE="$1"
REP0WITH="$2"

echo "CONVERTING $1 TO VW FORMAT"

# extract first line
head -n 1 $FILE > ${FILE}.info

# delete first line
sed -i '1d' $FILE

# add labels/features separator
sed -i "s/\(\(^\|,\| \)[0-9][0-9]*\)  *\([0-9][0-9]*:\)/\1 | \3/g" $FILE

# replace 0 with 
sed -i "s/^0,\(.*\) |/\1 $REP0WITH |/g" $FILE

# remove labels separators	
sed -i 's/,/ /g' $FILE

