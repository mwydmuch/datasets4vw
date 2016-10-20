#!/usr/bin/env bash

DATASET_NAME="Wiki10"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGaDdOeGliWF9EOTA"

bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

mv  "./$DATASET_NAME/wiki10_test.txt"  "./$DATASET_NAME/wiki10_test"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wiki10_test"

mv  "./$DATASET_NAME/wiki10_train.txt"  "./$DATASET_NAME/wiki10_train"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wiki10_train"

