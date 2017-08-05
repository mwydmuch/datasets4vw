#!/usr/bin/env bash


source text_format.sh

DATASET_NAME="WikiLSHTC-325K"
FILES_PREFIX="wikiLSHTC"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGSHE1SWx4TVRva3c"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
bash ${SCRIPT_DIR}/get_xml_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
