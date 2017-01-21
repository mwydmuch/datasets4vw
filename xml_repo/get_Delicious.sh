#!/usr/bin/env bash

DATASET_NAME="Delicious"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGdG1jZ19VS2NWRVU"

if [ ! -e $DATASET_NAME ]
then
    bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

    mv "./$DATASET_NAME/Delicious_data.txt" "./$DATASET_NAME/delicious_data"
    bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/delicious_data"

    #sed -i 's/ /\n/g' "./$DATASET_NAME/delicious_trSplit.txt"
    #sed -i 's/ /\n/g' "./$DATASET_NAME/delicious_tstSplit.txt"

    bash split_dataset.sh "./$DATASET_NAME/delicious_data" "./$DATASET_NAME/delicious_trSplit.txt" "./$DATASET_NAME/delicious_train"
    bash split_dataset.sh "./$DATASET_NAME/delicious_data" "./$DATASET_NAME/delicious_tstSplit.txt" "./$DATASET_NAME/delicious_test"

    rm "./$DATASET_NAME/delicious_trSplit.txt"
    rm "./$DATASET_NAME/delicious_tstSplit.txt"
fi