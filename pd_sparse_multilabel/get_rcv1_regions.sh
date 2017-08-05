#!/usr/bin/env bash

DATASET_NAME="rcv1_regions"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
bash ${SCRIPT_DIR}/get_pd_dataset.sh $DATASET_NAME
