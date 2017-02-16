#!/usr/bin/env bash

DATASET_NAME="LSHTC1"

if [ ! -e $DATASET_NAME ]
then
    make construct dataset=$DATASET_NAME

    bash ./pd_dataset_2_vw.sh "./$DATASET_NAME/$DATASET_NAME.train"
    bash ./pd_dataset_2_vw.sh "./$DATASET_NAME/$DATASET_NAME.heldout"
    bash ./pd_dataset_2_vw.sh "./$DATASET_NAME/$DATASET_NAME.test"
fi
