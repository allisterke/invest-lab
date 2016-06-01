#!/bin/bash

KEY=$1
COLOR=$2
BG=$3

if [[ -z $KEY ]]; then
  echo "usage: $0 <keyword> [forground-color] [background-color]"
  exit 1;
fi

if [[ -z $COLOR ]]; then
  COLOR=black
fi

if [[ -z $BG ]]; then
  BG=lightgreen
fi

while read -r LINE; do
  echo "$LINE" | \
    sed -r 's/('$KEY')/<span style="color:'$COLOR'; font-style:italic; font-weight:bolder; font-size:xx-large; background:'$BG';">\1<\/span>/g'
done
