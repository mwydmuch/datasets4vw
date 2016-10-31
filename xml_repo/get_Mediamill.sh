#!/usr/bin/env bash

DATASET_NAME="Mediamill"
DATASET_LINK="https://drive.google.com/uc?export=download&id=0B3lPMIHmG6vGY3B4TXRmZnZBTkk"

bash ./download_dataset.sh $DATASET_NAME $DATASET_LINK

mv "./$DATASET_NAME/Mediamill_data.txt" "./$DATASET_NAME/mediamill_data"
bash ./xml_dataset_2_vw.sh "./$DATASET_NAME/mediamill_data"

#sed -i 's/ /\n/g' "./$DATASET_NAME/mediamill_trSplit.txt"
#sed -i 's/ /\n/g' "./$DATASET_NAME/mediamill_tstSplit.txt"

bash split_dataset.sh "./$DATASET_NAME/mediamill_data" "./$DATASET_NAME/mediamill_trSplit.txt" "./$DATASET_NAME/mediamill_train"
bash split_dataset.sh "./$DATASET_NAME/mediamill_data" "./$DATASET_NAME/mediamill_tstSplit.txt" "./$DATASET_NAME/mediamill_test"

rm "./$DATASET_NAME/mediamill_trSplit.txt"
rm "./$DATASET_NAME/mediamill_tstSplit.txt"
