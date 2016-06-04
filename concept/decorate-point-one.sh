#!/bin/bash

while read -r LINE; do
  echo "$LINE" |
    perl -ne 's/(.*?)(要点一.*?所属板块[[:space:]　]*)((?:(?!要点[一|二|三|四|五|六|七|八|九|十]+).)*)(.*)/\1\n\2\n\3\n\4/g; print;' |
      sed -r '3 s/([^[:space:]]+)/<span style="color:OrangeRed; font-size:xx-large; font-weight:bold; font-style:italic;">\1<\/span>/g' |
        tr -d '\n' | sed -r 's/$/\n/g'
done
