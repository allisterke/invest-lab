#!/bin/bash

START=$(echo 'select max(date) + interval 1 day from invest.history_day' | mysql)
if [ $? -ne 0 ]; then
    echo 'cannot get start time from database'
    exit 1
fi
START=$(echo "$START" | tail -n 1 | tr -d '-')
END=$(date +%F | tr -d '-')

URL_TEMPLATE="http://quotes.money.163.com/service/chddata.html?code=%s%s&start=$START&end=$END"

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

DIR="history-$(date +%F)"

mkdir $DIR
if [ $? -ne 0 ]; then
#    echo "$DIR already exists"
    exit 1
fi

INDEX=1
cat ../sse.txt ../szse.txt | while read line; do
#echo 000518 | while read line; do
	CODE=$(echo $line | grep -o '[[:digit:]]*')
	
	printf '%05d now downloading %s\n' $INDEX $CODE

	curl -s $(generate_url $CODE) | iconv -f gbk | tail -n +2 | tac >> $DIR/$CODE.csv

	INDEX=$((INDEX + 1))
done

