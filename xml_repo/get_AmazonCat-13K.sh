#!/usr/bin/env bash

DATASET_NAME="AmazonCat-13K"
FILES_PREFIX="amazonCat"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGa2tMbVJGdDNSMGc"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
bash ${SCRIPT_DIR}/get_xml_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
