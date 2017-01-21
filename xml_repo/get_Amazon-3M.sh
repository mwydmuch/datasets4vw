#!/usr/bin/env bash

DATASET_NAME="Amazon-3M"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGUEd4eTRxaWl3YkE"

if [ ! -e $DATASET_NAME ]
then
    bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

    mv  "./$DATASET_NAME/amazon-3M_train.txt"  "./$DATASET_NAME/amazon-3M_train"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/amazon-3M_train"

    mv  "./$DATASET_NAME/amazon-3M_test.txt"  "./$DATASET_NAME/amazon-3M_test"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/amazon-3M_test"
fi
