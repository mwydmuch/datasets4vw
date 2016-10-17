#!/bin/sh

DATASET_NAME="Delicious"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGcy1xM2pJZ09MMGM"

sh ./download_dataset.sh $DATASET_NAME $DATASET_LINK
sh ./xml_rep_file_2_vw.sh "./$DATASET_NAME/Delicious_data.txt"

#sed -i 's/ /\n/g' "./$DATASET_NAME/delicious_trSplit.txt"
#sed -i 's/ /\n/g' "./$DATASET_NAME/delicious_tstSplit.txt"

sh split_dataset.sh "./$DATASET_NAME/Delicious_data.txt" "./$DATASET_NAME/delicious_trSplit.txt" "./$DATASET_NAME/delicious_train.txt"
sh split_dataset.sh "./$DATASET_NAME/Delicious_data.txt" "./$DATASET_NAME/delicious_tstSplit.txt" "./$DATASET_NAME/delicious_test.txt"
