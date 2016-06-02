#!/bin/bash

# args:
# 	$1: END date, format: 2016-05-01
#	$2: LIMIT, get recent LIMIT days data
# inputs:
#	stock code stream, use pipe like: cat sse.txt szse.txt | ...
# outputs:
#	get recent data to recent-$1-$2 and create a link recent
# 	recent data format:

END=$1
LIMIT=$2
FUTURE=$3

if [[ -z $END ]]; then
	END=$(date '+%F')
fi

if [[ -z $LIMIT ]]; then
	LIMIT=60
fi

if [[ -z $FUTURE ]]; then
	FUTURE=5
fi

USER=ally
PASSWORD=110110
DATABASE=invest
TABLE=TradeInfo

generate_vector() {
	RESULT=$(mysql -u $USER -p$PASSWORD -D $DATABASE -s -r -e "
		select t.close, t.diffrate
		from $TABLE t
		where t.code = '$1' and t.date <= '$END'
		order by t.date desc
		limit $LIMIT")

	if (( $(echo "$RESULT" | wc -l) < LIMIT )); then
		return 1
	fi

	FIRST=True
	ACCEPT=True
	ZEROS=0
	while read CLOSE DIFFRATE; do
		if [[ $FIRST = True ]]; then
			if [[ $CLOSE = 0 ]]; then
				ACCEPT=False
				break
			fi
			FIRST=False
		else
			if [[ $CLOSE = 0 ]]; then
				ZEROS=$((ZEROS + 1))
			fi
		fi
	done < <(echo "$RESULT")

	if [[ $ACCEPT = True ]] && ( [[ $ZEROS -eq 0 ]] || (( $(echo "$RESULT" | wc -l) / ZEROS >= 5)) ); then

		echo "$RESULT" | awk '{ print $2; }' | python -c "
import sys

rate = 1.0;
first = True;

while True:
	line = sys.stdin.readline()
	if not line:
		break

	diffrate = float(line)

	if first:
		first = False
	else:
		if diffrate == -100:
			diffrate = 0
		rate = rate * (1+diffrate/100)

	print rate "
	else
		return 1
	fi
}

generate_label() {
	RESULT=$(mysql -u $USER -p$PASSWORD -D $DATABASE -s -r -e "
		select t.close, t.diffrate
		from $TABLE t
		where t.code = '$1' and t.date > '$END'
		order by t.date
		limit $FUTURE")

	if (( $(echo "$RESULT" | wc -l) < FUTURE )); then
		return 1
	fi

	ACCEPT=True
#	while read CLOSE DIFFRATE; do
#		if [[ $CLOSE = 0 ]]; then
#			ACCEPT=False
#		fi
#	done < <(echo "$RESULT")

	if [[ $ACCEPT = True ]]; then
		echo "$RESULT" | awk '{ print $2; }' | python -c "
import sys

rate = 1.0;
first = True;

while True:
	line = sys.stdin.readline()
	if not line:
		break

	diffrate = float(line)

	if first:
		first = False
	else:
		if diffrate == -100:
			diffrate = 0
		rate = rate * (1+diffrate/100)

index = 0
if rate < 0.8:
	index = 0
elif rate < 0.9:
	index = 1
elif rate < 0:
	index = 2
elif rate < 1.1:
	index = 3
elif rate < 1.2:
	index = 4
else:
	index = 5

label = [0]*6;
label[index] = 1

for a in label:
	print a"
	else
		return 1
	fi
}

VECTORFILE="vector-$END-$LIMIT-$FUTURE.txt"
LABELFILE="label-$END-$LIMIT-$FUTURE.txt"
CODEFILE="code-$END-$LIMIT-$FUTURE.txt"

rm -f $VECTORFILE $LABELFILE $CODEFILE

generate_vector_and_label() {
	if [[ ! $1 =~ ^[[:digit:]]{6}$ ]]; then
		return
	fi

	VECTOR=$(generate_vector $1)
	if [[ $? -eq 0 ]]; then
		LABEL=$(generate_label $1)
	else
		LABEL=
	fi

	if [[ -n $VECTOR && -n $LABEL ]]; then
		echo $VECTOR | tr '\n' ' ' | sed 's/ *$/\n/g' >> $VECTORFILE
		echo $LABEL | tr '\n' ' ' | sed 's/ *$/\n/g' >> $LABELFILE
		echo $1 >> $CODEFILE
	else
		# exit 1
		:
	fi
}

cat szse.txt sse.txt | while read line; do
# while read line; do
	CODE=$(echo $line | grep -o '[[:digit:]]*')
	echo "processing $CODE"

	generate_vector_and_label $CODE
done

if [[ -f $VECTORFILE && -f $LABELFILE ]]; then
	
	rm vector.txt label.txt code.txt
	ln -s -f $VECTORFILE vector.txt
	ln -s -f $LABELFILE label.txt
	ln -s -f $CODEFILE code.txt
fi
