#!/bin/bash

./retrieve-suspension-stocks.sh $1 |
  ./decorate-point-one.sh |
  ./decorate-name.sh |
  ./decorate-main-points-li.sh |
  ./decorate-zx.sh |
  ./decorate-keyword.sh 注入 Red White |
  ./decorate-keyword.sh 重组 Red White |
  ./decorate-line-li.sh |
  ./decorate-html.sh > info.html
