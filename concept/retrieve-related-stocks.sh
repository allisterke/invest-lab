#!/bin/bash

join -t $'\t' -o 1.1 1.2 2.2 <(cat ../szse.txt ../sse.txt | tr -d ' ' | tr ',' '\t') \
  <( while read -r LINE; do echo "$LINE"; done | tr -d '\t' |
    sed -r 's/^.*?([[:digit:]]{6}).txt:/\1\t/g' )
