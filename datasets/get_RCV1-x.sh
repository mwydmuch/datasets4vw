#!/bin/sh

DATASET_NAME="RCV1-x"
DATASET_LINK="https://drive.google.com/uc?export=download&confirm=zxH_&id=0B3lPMIHmG6vGdnEzRWZWQWJMRnc"

sh ./download_dataset.sh $DATASET_NAME $DATASET_LINK
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/rcv1-x_test.txt"
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/rcv1-x_train.txt"

