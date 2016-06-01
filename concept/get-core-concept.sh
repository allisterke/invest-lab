#!/bin/bash

full_stock_id() {
  PRE=
  VALID=TRUE
  case $1 in
    6*)
      PRE=sh
      ;;
    0*)
      PRE=sz
      ;;
    3*)
      PRE=sz
      ;;
    *)
      VALID=FALSE
      ;;
  esac

  if [[ $VALID == TRUE ]]; then
    echo $PRE$1
  else
    return 1
  fi
}

TEMPLATE='http://f10.eastmoney.com/f10_v2/CoreConception.aspx?code='

core_concept() {
  ID=$(full_stock_id $CODE)
  if [[ $? -eq 0 ]]; then
    URL=$TEMPLATE$ID

    FLAG=FALSE
    while read LINE; do
      if [[ $LINE =~ .*页面内容.* ]]; then
        FLAG=TRUE
        continue
      elif [[ $LINE =~ .*页面尾部.* ]]; then
        FLAG=FALSE
        continue
      fi
      if [[ $FLAG == TRUE ]]; then
        echo $LINE
      fi
    done < <(curl -s "$URL")
  else
    echo 'not valid stock'
    return 1
  fi
}

DIR=concept-$(date '+%F')
rm -rf $DIR
mkdir -p $DIR
rm -f concept
ln -s -f $DIR concept

while read CODE; do
  echo "$CODE"

  CONCEPT=$(core_concept $CODE | tr '\r\n' ' ' | sed 's/<[^>]*>/ /g' | sed -r 's/^( |核心题材)*//g')

  if [[ $? -eq 0 ]]; then
    echo "$CONCEPT" > $DIR/$CODE.txt
  else
    echo 'not valid stock'
  fi

done
