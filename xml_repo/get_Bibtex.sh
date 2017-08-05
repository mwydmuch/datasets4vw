#!/usr/bin/env bash

DATASET_NAME="Bibtex"
FILES_PREFIX="bibtex"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGcy1xM2pJZ09MMGM"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
bash ${SCRIPT_DIR}/get_xml_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK