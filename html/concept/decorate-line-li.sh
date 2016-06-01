#!/bin/bash

echo '<ol style="list-style-type:decimal-leading-zero;">'

while read -r LINE; do
  echo "$LINE" | \
    sed -r 's/^(.*)$/<li>\1<\/li>/g'
done

echo '</ol>'
