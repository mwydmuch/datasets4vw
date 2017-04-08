#!/usr/bin/env bash

DATASET_NAME="$1"
DATASET_LINK="$2"

if [ ! -e $DATASET_NAME ]
then 
	if [ ! -e "./$DATASET_NAME.zip" ]
	then
	    echo "DOWNLOADING $DATASET_NAME ..."
		#wget $DATASET_LINK -P ./ -O "$DATASET_NAME.zip"
		perl google_drive_download.pl $DATASET_LINK "$DATASET_NAME.zip"
	fi
	
	echo "EXTRACING $DATASET_NAME ..."
	unzip -j -d "./$DATASET_NAME" "./$DATASET_NAME.zip"
fi
