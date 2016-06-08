#!/bin/bash

KEY=转型为

while read -r LINE; do
  echo "$LINE" |
    perl -ne 's/(要点[一|二|三|四|五|六|七|八|九|十]+.*?)([[:digit:]]+年[[:digit:]]+月[[:digit:]]+日|[[:digit:]]+年[[:digit:]]+月|[[:digit:]]+年)((?:(?![[:digit:]]+年[[:digit:]]+月[[:digit:]]+日|[[:digit:]]+年[[:digit:]]+月|[[:digit:]]+年).)*)('$KEY')/\1<span style="font-style:italic; font-weight:bolder; font-size:xx-large; background:lightgreen;">\2<\/span>\3<span style="color:red; font-style:italic; font-weight:bolder; font-size:xx-large;">\4<\/span>/g; print;'
done
