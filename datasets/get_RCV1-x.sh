#!/bin/sh

DATASET_NAME="RCV1-x"
DATASET_LINK="-"

sh ./download_dataset.sh $DATASET_NAME $DATASET_LINK
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/rcv1x_test.txt"
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/rcv1x_train.txt"

