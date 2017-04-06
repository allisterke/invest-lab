#!/bin/bash

URL_TEMPLATE="http://quotes.money.163.com/service/chddata.html?code=%s%s"

generate_url() {
	case $1 in
		(6*)
			printf $URL_TEMPLATE 0 $1
			;;
		(*)
			printf $URL_TEMPLATE 1 $1
			;;
	esac
}

DIR="history"

mkdir -p $DIR

INDEX=1
#cat ../sse.txt | while read line; do
#cat ../szse.txt | while read line; do
cat ../sse.txt ../szse.txt | while read line; do
	CODE=$(echo $line | grep -o '[[:digit:]]*')
	
	printf '%05d now downloading %s\n' $INDEX $CODE

	curl -s $(generate_url $CODE) | iconv -f gbk | tail -n +2 | tac > $DIR/$CODE.csv

	INDEX=$((INDEX + 1))
done

