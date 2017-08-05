# datasets4vw

Scripts to download and convert different datasets to Vowpal Wabbit format.
Repository contains scripts for the following datasets:

Usage: `bash ./<repo>/get_<dataset-name>.sh`

### [`xml_repo`](https://manikvarma.github.io/downloads/XC/XMLRepository.html) (multilabel): 
- Amazon-3M `(amazon-3M)`
- Amazon-670K `(amazon)`
- AmazonCat-13K `(amazonCat)`
- AmazonCat-14K `(amazonCat-14K)`
- Bibtex `(bibtex)`
- Delicious `(delicious)`
- Delicious-200K `(deliciousLarge)`
- EURLex-4K `(eurlex)`
- Mediamill `(mediamill)`
- RCV1-2K `(rcv1x)`
- Wiki10-31K `(wiki10)`
- WikiLSHTC-325K `(wikiLSHTC)`
- Wikipedia-500K `(WikipediaLarge-500K)`


### [`pd_sparse(_multiclass)`](http://www.cs.utexas.edu/~xrhuang/PDSparse/):
- aloi.bin 
- Dmoz 
- imageNet 
- LSHTC1 
- sector


### [`pd_sparse_multilabel`](http://www.cs.utexas.edu/~xrhuang/PDSparse/):
- Eur-Lex 
- rcv1_regions 
- bibtex
- LSHTCwiki


### Mac users need to install gnu version of sed: 
```
brew install gnu-sed
```