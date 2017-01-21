#!/usr/bin/env bash

DATASET_NAME="Wiki10" # Wiki10-31K
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGaDdOeGliWF9EOTA"

if [ ! -e $DATASET_NAME ]
then
    bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

    mv  "./$DATASET_NAME/wiki10_test.txt"  "./$DATASET_NAME/wiki10_test"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wiki10_test"

    mv  "./$DATASET_NAME/wiki10_train.txt"  "./$DATASET_NAME/wiki10_train"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wiki10_train"
fi
