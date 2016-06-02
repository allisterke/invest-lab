#!/bin/bash

START=$1
END=$2

if [[ -z $START || -z $END ]]; then
  END=$(date '+%Y%m%d')
  START=$(date -d 'last monday' '+%Y%m%d')
fi

URL_TEMPLATE="http://quotes.money.163.com/service/chddata.html?code=%s%s&start=$START&end=$END&fields=TCLOSE;HIGH;LOW;TOPEN;LCLOSE;CHG;PCHG;VOTURNOVER;VATURNOVER"

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

DIR="trade-info-$START-$END"

mkdir -p $DIR

INDEX=1
cat sse.txt szse.txt | while read line; do
	CODE=$(echo $line | grep -o '[[:digit:]]*')
	
	printf '%05d now downloading %s\n' $INDEX $CODE

	curl -s $(generate_url $CODE) | iconv -f gbk | tail -n +2 > $DIR/$CODE.csv

	INDEX=$((INDEX + 1))
done

