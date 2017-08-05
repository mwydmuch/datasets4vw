#!/usr/bin/env bash

DATASET_NAME="RCV1-2K"
FILES_PREFIX="rcv1x"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGdnEzRWZWQWJMRnc"

SCRIPT_DIR=$( dirname "${BASH_SOURCE[0]}" )
bash ${SCRIPT_DIR}/get_xml_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
