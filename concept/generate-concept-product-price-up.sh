#!/bin/bash

./retrieve-product-price-up.sh |
  ./decorate-name.sh |
  ./decorate-main-points-li.sh |
  ./decorate-price-up.sh |
  ./decorate-line-li.sh |
  ./decorate-html.sh > info.html
