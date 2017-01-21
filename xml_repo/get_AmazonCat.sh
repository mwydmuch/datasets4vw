#!/usr/bin/env bash

DATASET_NAME="AmazonCat" # AmazonCat-13K
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGa2tMbVJGdDNSMGc"

if [ ! -e $DATASET_NAME ]
then
    bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

    mv  "./$DATASET_NAME/amazonCat_test.txt"  "./$DATASET_NAME/amazonCat_test"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/amazonCat_test"

    mv  "./$DATASET_NAME/amazonCat_train.txt"  "./$DATASET_NAME/amazonCat_train"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/amazonCat_train"
fi
