#!/usr/bin/env bash

DATASET_NAME="RCV1-x"
DATASET_LINK="-"

bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

mv  "./$DATASET_NAME/rcv1x_test.txt"  "./$DATASET_NAME/rcv1x_test"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/rcv1x_test.txt"

mv  "./$DATASET_NAME/rcv1x_train.txt"  "./$DATASET_NAME/rcv1x_train"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/rcv1x_train.txt"

