#!/usr/bin/env bash

PD_MULTICLASS_DATASETS="aloi.bin Dmoz imageNet LSHTC1 sector"
PD_MULTILABEL_DATASETS="Eur-Lex rcv1_regions bibtex LSHTCwiki"
XML_DATASETS="Amazon-3M AmazonCat Bibtex DeliciousLarge Delicious Mediamill RCV1-x Wiki10 WikiLSHTC"

echo "PD SPARSE DATASETS"
cd pd_sparse_multiclass
for dataset in ${PD_MULTICLASS_DATASETS[@]}; do
    echo "DOWNLOADING $dataset ..."
    bash get_${dataset}.sh
done
cd ..

cd pd_sparse_multilabel
for dataset in ${PD_MULTILABEL_DATASETS[@]}; do
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

