#!/usr/bin/env bash

DATASET_NAME="$1"
FILES_PREFIX="$2"
DATASET_LINK="$3"

if [ ! -e $DATASET_NAME ]
then
    bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

    echo "PROCESSING $DATASET_NAME ..."

    mv  "./$DATASET_NAME/${FILES_PREFIX}_test.txt"  "./$DATASET_NAME/${FILES_PREFIX}_test"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/${FILES_PREFIX}_test"

    mv  "./$DATASET_NAME/${FILES_PREFIX}_train.txt"  "./$DATASET_NAME/${FILES_PREFIX}_train"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/${FILES_PREFIX}_train"
fi
