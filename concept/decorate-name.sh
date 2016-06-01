#!/bin/bash

COLOR=$1
BG=$2

if [[ -z $COLOR ]]; then
  COLOR=DarkBlue
fi

if [[ -z $BG ]]; then
  BG=Cyan
fi

while read -r LINE; do
  echo "$LINE" | \
    sed -r 's/^([[:digit:]]{6})([[:space:]]+)([^[:space:]]+)/<a href="http:\/\/guba.eastmoney.com\/list,\1.html" target="_blank"><span style="color:'$COLOR'; font-style:italic; font-weight:bolder; font-size:xx-large; background:'$BG';">\1\2\3<\/span><\/a>/g'
done
