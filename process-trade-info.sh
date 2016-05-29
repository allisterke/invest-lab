#!/bin/bash

# inputs:
#   $1 - file name or directory name
# outputs:
#   insert into TradeInfo values (...)

FILELIST=$(mktemp -t trade-info-XXXXXX)

if [[ -d $1 ]]; then
  find $1 -type f >> $FILELIST
elif [[ -f $1 ]]; then
  echo "$1" >> $FILELIST
fi

IFS=,

cat $FILELIST | while read FILE; do
  cat $FILE | tr -d '\r' |  while read DATE TCODE NAME CLOSE TOP BOTTOM \
      OPEN YCLOSE DIFF DIFFRATE VOLUME AMOUNT; do
    CODE=$(echo $TCODE | tr -d -c '[[:digit:]]')

    if [[ $CLOSE = '0.0' ]]; then
      DIFF='-1'
      DIFFRATE='-1'
    fi

    INSERT="insert into TradeInfo values('$DATE', '$CODE', $CLOSE, $TOP, $BOTTOM, \
$OPEN, $YCLOSE, $DIFF, $DIFFRATE, $VOLUME, $AMOUNT);"
    echo "$INSERT"
  done
done

rm -f $FILELIST
