#!/bin/bash

#grep '转型\|注入\|重组' concept/* |
grep '白酒' concept/* |
  ./retrieve-related-stocks.sh |
  ./decorate-name.sh |
  ./decorate-point-one.sh |
  ./decorate-main-points-li.sh |
  ./decorate-keyword.sh 白酒 LimeGreen White |
  ./decorate-line-li.sh |
  ./decorate-html.sh > info.html
