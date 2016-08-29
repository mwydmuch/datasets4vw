#!/bin/sh

DATASET_NAME="Wiki10"
DATASET_LINK="-"

sh ./download_dataset.sh $DATASET_NAME $DATASET_LINK
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/wiki10_test.txt" 30938
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/wiki10_train.txt" 30938

