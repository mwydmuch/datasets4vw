#!/usr/bin/env bash

DATASET_NAME="Eurlex"
FILES_PREFIX="eurlex"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGU0VTR1pCejFpWjg"

bash ./process_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
