#!/usr/bin/env bash

XML_DATASETS="Amazon Amazon-3M AmazonCat AmazonCat-14K Bibtex Eurlex Delicious DeliciousLarge Mediamill RCV1-x Wiki10 WikiLSHTC Wikipedia500K"

echo "XML REPO DATASETS"
cd xml_repo
for dataset in ${XML_DATASETS[@]}; do
    bash get_${dataset}.sh
done
cd ..

