#!/bin/bash

# inputs:
#   $1 - file name or directory name
# outputs:
#   insert into $TABLE values (...)

FILELIST=$(mktemp -t trade-info-XXXXXX)

if [[ -d $1 ]]; then
  find $1 -type f >> $FILELIST
elif [[ -f $1 ]]; then
  echo "$1" >> $FILELIST
fi

IFS=,
TABLE=invest.history_day

cat $FILELIST | while read FILE; do
  cat $FILE | tr -d '\r' |  while read DATE TCODE NAME CLOSE TOP BOTTOM \
      OPEN YCLOSE DIFF DIFFRATE TURNOVER_RATE VOLUME TURNOVER TOTAL CIRCULATION DEALS; do
    CODE=$(echo $TCODE | tr -d -c '[[:digit:]]')

    INSERT="insert into $TABLE values('$DATE', '$CODE', '$NAME', $CLOSE, $TOP, $BOTTOM, \
$OPEN, $YCLOSE, $DIFF, $DIFFRATE, $TURNOVER_RATE, $VOLUME, $TURNOVER, $TOTAL, $CIRCULATION, $DEALS);"
    echo "$INSERT" | sed 's/None/null/g'
  done
done

rm -f $FILELIST
