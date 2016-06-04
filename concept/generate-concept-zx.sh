#!/bin/bash

grep '转型\|注入\|重组' concept/* |
  ./retrieve-related-stocks.sh |
  ./decorate-name.sh |
  ./decorate-point-one.sh |
  ./decorate-main-points-li.sh |
  ./decorate-cz.sh |
  ./decorate-keyword.sh 注入 Red White |
  ./decorate-line-li.sh |
  ./decorate-html.sh > info.html
