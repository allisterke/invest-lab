#!/bin/bash

while read -r LINE; do
  echo "$LINE" | \
    perl -ne 's/(要点[一|二|三|四|五|六|七|八|九|十]+)((?:(?!要点[一|二|三|四|五|六|七|八|九|十]+).)*)/<li>\1\2<\/li>/g; print;' |\
    sed -r 's/(要点[一|二|三|四|五|六|七|八|九|十]+[^　]{,30})/<span style="background-color:PapayaWhip; font-size:large; font-weight:bold;">\1<\/span>/g' |\
    sed -r 's/^(.*)$/<ul>\1<\/ul>/g'
done
