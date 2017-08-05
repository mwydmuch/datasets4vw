#!/usr/bin/env bash

DATASET_NAME="Delicious"
FILES_PREFIX="delicious"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGdG1jZ19VS2NWRVU"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
bash ${SCRIPT_DIR}/get_xml_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
