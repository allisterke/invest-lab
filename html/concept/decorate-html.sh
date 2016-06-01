#!/bin/bash

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">'
echo '</head>'
echo '<body>'

while read -r LINE; do
  echo "$LINE"
done

echo '</body>'
echo '</html>'
