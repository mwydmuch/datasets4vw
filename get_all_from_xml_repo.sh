#!/usr/bin/env bash

XML_DATASETS="Amazon-670K Amazon-3M AmazonCat-13K AmazonCat-14K Bibtex Eurlex Delicious Delicious-200K Mediamill RCV1-2K Wiki10-31K WikiLSHTC-325K Wikipedia-500K"

echo "XML REPO DATASETS"
cd xml_repo
for dataset in ${XML_DATASETS[@]}; do
    bash get_${dataset}.sh
done
cd ..

