#!/usr/bin/env bash

PD_MULTICLASS_DATASETS="aloi.bin Dmoz imageNet LSHTC1 sector"
PD_MULTILABEL_DATASETS="Eur-Lex rcv1_regions bibtex LSHTCwiki"

echo "PD SPARSE DATASETS"
cd pd_sparse_multiclass
for dataset in ${PD_MULTICLASS_DATASETS[@]}; do
    bash get_${dataset}.sh
done
cd ..

cd pd_sparse_multilabel
for dataset in ${PD_MULTILABEL_DATASETS[@]}; do
    bash get_${dataset}.sh
done
cd ..

