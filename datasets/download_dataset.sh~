#!/bin/sh

DATASET_NAME="$1"
DATASET_LINK="$2"

if [ ! -e $DATASET_NAME ]
then 
	if [ ! -e "./$DATASET_NAME.zip" ]
	then
		wget $DATASET_LINK -P ./ -O "$DATASET_NAME.zip"
	fi
	unzip -j -d "./$DATASET_NAME" "./$DATASET_NAME.zip"
fi
