#!/bin/bash

# inputs: None
# outputs:
#   save sse code list to sse-YYYY-MM-DD.txt and create link sse.txt
#   file format is: 600000,XXXXXX

URL='http://query.sse.com.cn/security/stock/downloadStockListFile.do?csrcCode=&stockCode=&areaName=&stockType=1'
REFERER='http://www.sse.com.cn/assortment/stock/list/share/'

CONTENT=$(mktemp content-XXXXXX -t)

mkdir -p code
CODELIST=code/sse-$(date +%F).txt
rm -f $CODELIST

# download code list

curl -s -o $CONTENT --referer "$REFERER" "$URL"

# collect stock code
cat $CONTENT | iconv -f gbk | tail -n +2 | \
    awk '{print $3","$4;}' \
	>> $CODELIST

# create link
LINK=../sse.txt
rm -f $LINK
ln -s -f $(pwd)/$CODELIST $LINK

# clean up
rm -f $CONTENT

echo 'szse stock code list downloaded'
