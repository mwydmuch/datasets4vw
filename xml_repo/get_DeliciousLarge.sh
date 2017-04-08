#!/usr/bin/env bash

DATASET_NAME="DeliciousLarge" # Delicious-200K
FILES_PREFIX="deliciousLarge"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGR3lBWWYyVlhDLWM"

bash ./process_dataset.sh $DATASET_NAME $FILES_PREFIX $DATASET_LINK
