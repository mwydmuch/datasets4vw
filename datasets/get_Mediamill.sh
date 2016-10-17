#!/bin/sh

DATASET_NAME="Mediamill"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGY3B4TXRmZnZBTkk"

sh ./download_dataset.sh $DATASET_NAME $DATASET_LINK
bash ./xml_rep_file_2_vw.sh "./$DATASET_NAME/Mediamill_data.txt"

#sed -i 's/ /\n/g' "./$DATASET_NAME/mediamill_trSplit.txt"
#sed -i 's/ /\n/g' "./$DATASET_NAME/mediamill_tstSplit.txt"

sh split_dataset.sh "./$DATASET_NAME/Mediamill_data.txt" "./$DATASET_NAME/mediamill_trSplit.txt" "./$DATASET_NAME/Mediamill_train.txt"
sh split_dataset.sh "./$DATASET_NAME/Mediamill_data.txt" "./$DATASET_NAME/mediamill_tstSplit.txt" "./$DATASET_NAME/Mediamill_test.txt"
