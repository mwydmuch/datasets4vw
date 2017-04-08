#!/usr/bin/env bash

DATASET_NAME="Amazon" # Amazon-670K
FILES_PREFIX="amazon"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGdUJwRzltS1dvUVk"

bash ./process_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
