#!/usr/bin/env bash

DATASET_NAME="Bibtex"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGcy1xM2pJZ09MMGM"

if [ ! -e $DATASET_NAME ]
then
    bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

    mv "./$DATASET_NAME/Bibtex_data.txt" "./$DATASET_NAME/bibtex_data"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/bibtex_data"

    #sed -i 's/ /\n/g' "./$DATASET_NAME/bibtex_trSplit.txt"
    #sed -i 's/ /\n/g' "./$DATASET_NAME/bibtex_tstSplit.txt"

    bash split_dataset.sh "./$DATASET_NAME/bibtex_data" "./$DATASET_NAME/bibtex_trSplit.txt" "./$DATASET_NAME/bibtex_train"
    bash split_dataset.sh "./$DATASET_NAME/bibtex_data" "./$DATASET_NAME/bibtex_tstSplit.txt" "./$DATASET_NAME/bibtex_test"

    rm "./$DATASET_NAME/bibtex_trSplit.txt"
    rm "./$DATASET_NAME/bibtex_tstSplit.txt"
fi