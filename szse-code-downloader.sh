#!/bin/bash

# inputs: None
# outputs:
#   save szse code list to szse-YYYY-MM-DD.txt and create a link szse.txt
#   file content format is: 300000,XXXXX

URL='http://www.szse.cn/szseWeb/ShowReport.szse?SHOWTYPE=EXCEL&CATALOGID=1110&tab1PAGENUM=1&ENCODE=1&TABKEY=tab1'

CONTENT=$(mktemp -t content-sz-XXXXXX)

# download code list

curl -s -o $CONTENT "$URL"

# extract code list

CODELIST=szse-$(date +%F).txt
rm -f $CODELIST

cat $CONTENT | iconv -f gbk | tr -d '\r\n' | grep -P -o '<tr.*?</tr>' | tail -n +2 \
	| sed 's/<[^>]*>/,/g' | head -n -1 | awk 'BEGIN { FS=","; OFS=","; }; { print $3, $5; };' \
	>> $CODELIST

rm -f szse.txt
ln -s -f $CODELIST szse.txt

rm -f $CONTENT
