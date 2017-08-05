#!/usr/bin/env bash

DATASET_NAME="AmazonCat-14K"
FILES_PREFIX="amazonCat-14K"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGaDFqU2E5U0dxS00"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
bash ${SCRIPT_DIR}/get_xml_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK