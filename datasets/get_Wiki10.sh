#!/usr/bin/env bash

DATASET_NAME="Wiki10"
DATASET_LINK="-"

bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

mv  "./$DATASET_NAME/wiki10_test.txt"  "./$DATASET_NAME/wiki10_test"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wiki10_test.txt"

mv  "./$DATASET_NAME/wiki10_tarin.txt"  "./$DATASET_NAME/wiki10_train"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wiki10_train.txt"

