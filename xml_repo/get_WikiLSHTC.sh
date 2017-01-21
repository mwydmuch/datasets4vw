#!/usr/bin/env bash

DATASET_NAME="WikiLSHTC" # WikiLSHTC-325K
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGSHE1SWx4TVRva3c"

if [ ! -e $DATASET_NAME ]
then
    bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

    mv  "./$DATASET_NAME/wikiLSHTC_test.txt"  "./$DATASET_NAME/wikiLSHTC_test"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wikiLSHTC_test"

    mv  "./$DATASET_NAME/wikiLSHTC_train.txt"  "./$DATASET_NAME/wikiLSHTC_train"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wikiLSHTC_train"
fi
