#!/bin/bash

cat ../sse.txt ../szse.txt | grep -o '[[:digit:]]*' | ./get-core-concept.sh | cat -n
