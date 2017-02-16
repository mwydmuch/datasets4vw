#!/usr/bin/env bash

PD_DATASETS="aloi.bin Dmoz imageNet LSHTC1 sector"
XML_DATASETS="Amazon-3M AmazonCat Bibtex DeliciousLarge Delicious Mediamill RCV1-x Wiki10 WikiLSHTC"

echo "PD SPARSE DATASETS"
cd pd_sparse
for dataset in ${PD_DATASETS[@]}; do
    echo "DOWNLOADING $dataset ..."
    bash get_${dataset}.sh
done
cd ..

echo "XML REPO DATASETS"
cd xml_repo
for dataset in ${XML_DATASETS[@]}; do
    echo "DOWNLOADING $dataset ..."
    bash get_${dataset}.sh
done
cd ..

