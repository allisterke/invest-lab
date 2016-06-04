#!/bin/bash

grep '唯一' -H concept/* |
  ./retrieve-related-stocks.sh
