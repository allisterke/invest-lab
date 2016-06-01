#!/bin/bash

KEY=转型为

while read -r LINE; do
  echo "$LINE" |\
    perl -ne 's/([[:digit:]]+年[[:digit:]]+月[[:digit:]]+日|[[:digit:]]+年[[:digit:]]+月|[[:digit:]]+年)((?:(?![[:digit:]]+年[[:digit:]]+月[[:digit:]]+日|[[:digit:]]+年[[:digit:]]+月|[[:digit:]]+年).)*)('$KEY')/<span style="font-style:italic; font-weight:bolder; font-size:xx-large; background:lightgreen;">\1<\/span>\2<span style="color:red; font-style:italic; font-weight:bolder; font-size:xx-large;">\3<\/span>/g; print;'
done
