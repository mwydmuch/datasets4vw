#!/usr/bin/env bash

DATASET_NAME="EURLex-4K"
FILES_PREFIX="eurlex"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGU0VTR1pCejFpWjg"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
bash ${SCRIPT_DIR}/get_xml_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
