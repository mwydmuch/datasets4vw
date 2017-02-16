#!/usr/bin/env bash

cat "$1" | grep -o "[1-9][0-9]* " | sort | uniq | wc -l
