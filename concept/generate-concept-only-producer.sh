#!/bin/bash

./retrieve-only-producer.sh |
./decorate-name.sh |
./decorate-main-points-li.sh |
./decorate-keyword.sh 唯一 Red White |
./decorate-line-li.sh |
./decorate-html.sh > info.html
