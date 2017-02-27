#!/usr/bin/env bash

DATASET_NAME="rcv1_regions"

if [ ! -e $DATASET_NAME ]
then
    make construct dataset=$DATASET_NAME
    
    bash ./remap_classes.sh "./$DATASET_NAME/$DATASET_NAME.train" "./$DATASET_NAME/$DATASET_NAME.heldout" "./$DATASET_NAME/$DATASET_NAME.test"

    bash ./pd_dataset_2_vw.sh "./$DATASET_NAME/$DATASET_NAME.train"
    bash ./pd_dataset_2_vw.sh "./$DATASET_NAME/$DATASET_NAME.heldout"
    bash ./pd_dataset_2_vw.sh "./$DATASET_NAME/$DATASET_NAME.test"
    
fi
