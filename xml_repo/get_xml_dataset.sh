#!/usr/bin/env bash

DATASET_NAME="$1"
FILES_PREFIX="$2"
DATASET_LINK="$3"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )

SED=sed
if [ $(uname -s) == Darwin ]; then
    SED=gsed
fi

function xml_dataset4vw {
    FILE="$1"

    # Extract metadata
    INFO=$(head -n 1 $FILE | grep -o "[0-9]\+")
    INFOARRAY=($INFO)
    echo ${INFOARRAY[0]} >> ${FILE}.examples
    echo ${INFOARRAY[1]} >> ${FILE}.features
    echo ${INFOARRAY[2]} >> ${FILE}.labels

    echo "CONVERTING $FILE TO VW FORMAT ..."
    echo "${INFOARRAY[0]} EXAMPLES, ${INFOARRAY[1]} FEATURES, ${INFOARRAY[2]} LABELS"

    # Delete first line
    $SED -i "1d" $FILE

    # Add labels/features separator
    $SED -i "s/\(\(^\|,\| \)[0-9]\{1,\}\)  *\([0-9]\+:\)/\1 | \3/g" $FILE

    # replace 0 with the highest label
    # $SED -i "s/^0[ ,]\(.*\)|/\1 ${INFOARRAY[2]} |/g" $FILE

    # replace comas with spaces
    # $SED -i "s/,/ /g" $FILE
}


echo "GETTING $FILES_PREFIX ($DATASET_NAME) ..."
if [ ! -e ./$FILES_PREFIX ]; then
    if [ ! -e "./$FILES_PREFIX.zip" ]; then
        echo "DOWNLOADING ${FILES_PREFIX}.zip ..."
        #wget $DATASET_LINK -P ./ -O "$FILES_PREFIX.zip"
        perl ${SCRIPT_DIR}/../tools/google_drive_download.pl $DATASET_LINK "$FILES_PREFIX.zip"
    fi

    echo "EXTRACTING $FILES_PREFIX ..."
    unzip -j -d "./$FILES_PREFIX" "./$FILES_PREFIX.zip"
fi

if [ -e "./$FILES_PREFIX/${FILES_PREFIX}_train.txt" ]; then
    # and "./$FILES_PREFIX/${FILES_PREFIX}_test.txt"

    echo "PROCESSING ${FILES_PREFIX} ..."

    mv  "./$FILES_PREFIX/${FILES_PREFIX}_train.txt"  "./$FILES_PREFIX/${FILES_PREFIX}_train"
    xml_dataset4vw "./$FILES_PREFIX/${FILES_PREFIX}_train"

    mv  "./$FILES_PREFIX/${FILES_PREFIX}_test.txt"  "./$FILES_PREFIX/${FILES_PREFIX}_test"
    xml_dataset4vw "./$FILES_PREFIX/${FILES_PREFIX}_test"

    # bash ${SCRIPT_DIR}/../tools/remap_dataset.sh "./$FILES_PREFIX/${FILES_PREFIX}_train" "./$FILES_PREFIX/${FILES_PREFIX}_test"
fi

if [ -e "./$FILES_PREFIX/${FILES_PREFIX}_data.txt" ]; then

    echo "PROCESSING ${FILES_PREFIX} ..."

    mv "./$FILES_PREFIX/${FILES_PREFIX}_data.txt" "./$FILES_PREFIX/${FILES_PREFIX}_data"
    xml_dataset4vw "./$FILES_PREFIX/${FILES_PREFIX}_data"

    # bash ${SCRIPT_DIR}/../tools/remap_dataset.sh "./$FILES_PREFIX/${FILES_PREFIX}_data"

    bash ${SCRIPT_DIR}/../tools/split_dataset.sh "./$FILES_PREFIX/${FILES_PREFIX}_data" "./$FILES_PREFIX/${FILES_PREFIX}_trSplit.txt" "./$FILES_PREFIX/${FILES_PREFIX}_train"
    bash ${SCRIPT_DIR}/../tools/split_dataset.sh "./$FILES_PREFIX/${FILES_PREFIX}_data" "./$FILES_PREFIX/${FILES_PREFIX}_tstSplit.txt" "./$FILES_PREFIX/${FILES_PREFIX}_test"

    rm "./$FILES_PREFIX/${FILES_PREFIX}_trSplit.txt"
    rm "./$FILES_PREFIX/${FILES_PREFIX}_tstSplit.txt"
fi

rm $FILES_PREFIX.zip
