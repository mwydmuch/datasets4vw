#!/bin/sh

DATASET_NAME="WikiLSHTC"
DATASET_LINK="-"

sh ./download_dataset.sh $DATASET_NAME $DATASET_LINK
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/wikiLSHTC_test.txt"
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/wikiLSHTC_train.txt"

