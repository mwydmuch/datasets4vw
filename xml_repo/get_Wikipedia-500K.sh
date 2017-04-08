#!/usr/bin/env bash

DATASET_NAME="Wikipedia-500K"
FILES_PREFIX="WikipediaLarge-500K"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGRmEzVDVkNjBMR3c"

bash ./process_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
