#!/usr/bin/env bash

DATASET_NAME="RCV1-x" # RCV1-2K
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGdnEzRWZWQWJMRnc"

if [ ! -e $DATASET_NAME ]
then
    bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

    mv  "./$DATASET_NAME/rcv1x_test.txt"  "./$DATASET_NAME/rcv1x_test"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/rcv1x_test"

    mv  "./$DATASET_NAME/rcv1x_train.txt"  "./$DATASET_NAME/rcv1x_train"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/rcv1x_train"
fi
