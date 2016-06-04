#!/bin/bash

./get-top-price-up-stocks.js |
  grep -o '[[:digit:]]\{6\}' | sort |
  while read -r CODE; do
    FILE=concept/$CODE.txt
    if [[ -f $FILE ]]; then
      grep -H '.*' $FILE
    fi
  done |
  ./retrieve-related-stocks.sh
