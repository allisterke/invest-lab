#!/bin/bash

DATE=$1

if [[ -z $DATE ]]; then
  DATE=$(date '+%F')
fi

LAST=$(date -d "$DATE -1 days" '+%F')

(curl -s -g 'http://datainterface.eastmoney.com/EM_DataCenter/JS.aspx?type=FD&sty=SRB&st=0&sr=-1&p=1&ps=500&js=var%20info={pages:(pc),data:[(x)]}&mkt=1&fd='$DATE ; echo '; console.log(info.pages); info.data.map(function(x) { console.log(x);});') \
  | nodejs | grep "$DATE$" | grep -v "停牌一天" | sort -t ',' -k8 | cat -n
