#!/bin/bash

# inputs: None
# outputs:
#   save sse code list to sse-YYYY-MM-DD.txt and create link sse.txt
#   file format is: 600000,XXXXXX

URL='http://biz.sse.com.cn/sseportal/webapp/datapresent/SSEQueryStockInfoAct?keyword=&reportName=BizCompStockInfoRpt&PRODUCTID=&PRODUCTJP=&PRODUCTNAME=&CURSOR=1'

HEADER=$(mktemp header-XXXXXX -t)
CONTENT=$(mktemp content-XXXXXX -t)

mkdir -p code
CODELIST=code/sse-$(date +%F).txt
rm -f $CODELIST

# download code list

while [[ -n $URL ]]; do
	echo "processing $URL"

	curl -s -D $HEADER -o $CONTENT "$URL"

	# detect charset
	CHARSET=GBK
	TMP=$(cat $HEADER | grep -i 'charset=[[:alnum:]-]*' | head -n 1 | awk 'BEGIN { FS="="; }; {print $2}')
	if [ -n $TMP ]; then
		CHARSET=$TMP
	fi

	# collect stock code
	cat $CONTENT | iconv -f $CHARSET | tr -d '\r\n' \
		| grep -o '<tr><td[^>]*><a[^>]*>[[:digit:]]\{6\}</a></td><td[^>]*>[^<]*</td></tr>' \
		| sed 's/<tr><td[^>]*><a[^>]*>\([[:digit:]]\{6\}\)<\/a><\/td><td[^>]*>\([^<]*\)<\/td><\/tr>/\1,\2/g' \
		>> $CODELIST

	# detect next url
	TMP=$(cat $CONTENT | iconv -f $CHARSET | grep -o '<a href=".*">下一页</a>')

	if [[ -n $TMP ]]; then
		URL=$(echo $TMP | grep -o '".*"' | tr -d '"')
		if [[ ! $URL =~ '^http://.*' ]]; then
			URL='http://biz.sse.com.cn'$URL
		fi
	else
		URL=
	fi
done

# create link
LINK=../sse.txt
rm -f $LINK
ln -s -f $(pwd)/$CODELIST $LINK

# clean up
rm -f $HEADER $CONTENT
