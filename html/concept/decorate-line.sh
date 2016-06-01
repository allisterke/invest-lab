#!/bin/bash

I=0
while read -r LINE; do
  I=$((I+1))
  echo "$LINE" | \
    sed -r 's/^(.*)$/<div style="color:BlueViolet; font:xx-large;">'$I'<\/div><div>\1<\/div><br \/><hr \/><br \/>/g'
done
