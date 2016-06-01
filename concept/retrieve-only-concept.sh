#!/bin/bash

join -o 1.1 1.2 2.2 <(cat ../szse.txt ../sse.txt | tr -d ' ' | tr ',' ' ') <(grep '唯一' -H concept/* | tr ' ' ',' | sed -r 's/^.*?([[:digit:]]{6}).txt:/\1 /g' )
