#!/bin/bash

KEY=转型为

while read -r LINE; do
  echo "$LINE" |\
    perl -ne 's/(重组)((?:(?!重组).)*)('$KEY')/<span style="color:Orange; font-style:italic; font-weight:bolder; font-size:xx-large;">\1<\/span>\2<span style="color:red; font-style:italic; font-weight:bolder; font-size:xx-large;">\3<\/span>/g; print;'
done
