#!/usr/bin/env bash

DATASET_TRAIN="$1"
DATASET_TEST="$2"

echo "REMAPPING $1 AND $2 ..."

if [ ! -e fast_remap ]
then
    g++ fast_remap.cpp -std=c++11 -o fast_remap
fi

./fast_remap $DATASET_TRAIN $DATASET_TEST
rm $DATASET_TRAIN
mv "${DATASET_TRAIN}.new" $DATASET_TRAIN
rm $DATASET_TEST
mv "${DATASET_TEST}.new" $DATASET_TEST

