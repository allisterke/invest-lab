#!/bin/bash

join -o 1.1 1.2 2.2 <(cat ../szse.txt ../sse.txt | tr ',' ' ') <(grep '\(提价\|涨价\)' -H concept/* | tr -d ' ' | sed -r 's/^.*?([[:digit:]]{6}).txt:/\1 /g' )
