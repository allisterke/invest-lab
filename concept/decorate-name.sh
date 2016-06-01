#!/bin/bash

COLOR=$1
BG=$2

if [[ -z $COLOR ]]; then
  COLOR=DarkBlue
fi

if [[ -z $BG ]]; then
  BG=Cyan
fi

market() {
  case $1 in
    6*)
      echo sh
      ;;
    *)
      echo sz
      ;;
  esac
}

while read -r LINE; do
  CODE=$(echo "$LINE" | sed -r 's/^([[:digit:]]{6})([[:space:]]+)([^[:space:]]+)/\1/')
  echo "$LINE" | \
    sed -r 's/^([[:digit:]]{6})([[:space:]]+)([^[:space:]]+)/<span style="color:'$COLOR'; font-style:italic; font-weight:bolder; font-size:xx-large;"><a href="http:\/\/guba.eastmoney.com\/list,\1.html" target="_blank">\1<\/a>\2<a href="http:\/\/gu.qq.com\/'$(market $CODE)'\1" target="_blank">\3<\/a><\/span>/g'
done
