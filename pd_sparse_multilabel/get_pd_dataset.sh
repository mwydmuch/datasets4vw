#!/usr/bin/env bash

DATASET_NAME=$1

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )

SED=sed
if [ $(uname -s) == Darwin ]; then
    SED=gsed
fi

function pd_dataset2vw {
    FILE="$1"

    # get metadata
    CLASSES=$(cat ${FILE} | grep -o "^[0-9]*\|,[0-9]*" | sed 's/,*//' | sort -g | uniq | wc -l)
    echo $CLASSES >> ${FILE}.labels
    EXAMPLES=$(cat ${FILE} | wc -l)
    echo $EXAMPLES >> ${FILE}.examples

    echo "CONVERTING $FILE TO VW FORMAT ..."
    echo "$EXAMPLES EXAMPLES, $CLASSES CLASSES"

    # add labels/features separator
    $SED -i "s/\(\(^\|,\| \)[0-9]\+\)  *\([0-9]\+:\)/\1 | \3/g" $FILE

    # replace 0 with the highest label
    # $SED -i "s/^0[ ,]\(.*\)|/\1 $CLASSES |/g" $FILE

    # replace comas with spaces
    # $SED -i 's/,/ /g' $FILE
}


echo "GETTING $DATASET_NAME ..."
if [ ! -e $DATASET_NAME ]; then
    make --file=${SCRIPT_DIR}/Makefile get dataset=$DATASET_NAME
fi

if [ -e ./$DATASET_NAME/$DATASET_NAME.train ]; then
    mv ./$DATASET_NAME/$DATASET_NAME.train ./$DATASET_NAME/${DATASET_NAME}_train
    mv ./$DATASET_NAME/$DATASET_NAME.heldout ./$DATASET_NAME/${DATASET_NAME}_heldout
    mv ./$DATASET_NAME/$DATASET_NAME.test ./$DATASET_NAME/${DATASET_NAME}_test

    bash ${SCRIPT_DIR}/../tools/remap_dataset.sh "./$DATASET_NAME/${DATASET_NAME}_train" "./$DATASET_NAME/${DATASET_NAME}_heldout" "./$DATASET_NAME/${DATASET_NAME}_test"

    pd_dataset2vw "./$DATASET_NAME/${DATASET_NAME}_train"
    pd_dataset2vw "./$DATASET_NAME/${DATASET_NAME}_heldout"
    pd_dataset2vw "./$DATASET_NAME/${DATASET_NAME}_test"
fi
