#!/usr/bin/env bash

DATASET_NAME="Wiki10" # Wiki10-31K
FILES_PREFIX="wiki10"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGaDdOeGliWF9EOTA"

bash ./process_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
