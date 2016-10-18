#!/usr/bin/env bash

DATASET_NAME="WikiLSHTC"
DATASET_LINK="-"

bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

mv  "./$DATASET_NAME/wikiLSHTC_test.txt"  "./$DATASET_NAME/wikiLSHTC_test"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wikiLSHTC_test.txt"

mv  "./$DATASET_NAME/wikiLSHTC_train.txt"  "./$DATASET_NAME/wikiLSHTC_train"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/wikiLSHTC_train.txt"

