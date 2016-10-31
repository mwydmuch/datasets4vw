#!/usr/bin/env bash

DATASET_NAME="DeliciousLarge"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGR3lBWWYyVlhDLWM"

bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

mv  "./$DATASET_NAME/deliciousLarge_train.txt"  "./$DATASET_NAME/deliciousLarge_train"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/deliciousLarge_train"

mv  "./$DATASET_NAME/deliciousLarge_test.txt"  "./$DATASET_NAME/deliciousLarge_test"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/deliciousLarge_test"

