#!/usr/bin/env bash

cat "$1" | grep -o "(^|,)[0-9]*" | sort | uniq | wc -l
cat "$1" | grep -o "^[0-9]*\|,[0-9]*" | sed 's/,*//' | sort | uniq | wc -l
