#!/usr/bin/env bash

echo "REMAPING CLASSES IN FILES $1, $2, $3"

if [ ! -e fast_remap ]
then
    g++ fast_remap.cpp -std=c++11 -o fast_remap
fi

./fast_remap ${1} ${2} ${3}

rm ${1}
mv ${1}.new ${1}

rm ${2}
mv ${2}.new ${2}

rm ${3}
mv ${3}.new ${3}

