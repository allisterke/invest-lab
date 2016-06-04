#!/bin/bash

grep '\(提价\|涨价\)' -H concept/* |
  ./retrieve-related-stocks.sh
