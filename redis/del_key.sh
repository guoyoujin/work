#!/bin/bash

# date: 2018-04-25
# author: zhouwei
# email: xiaomao361@163.com
# func: delete redis key

patientName=$1
DB=
user=
password=
host=
py=/home/tongxin/zhouwei/script/oss_dicom/oss_env/bin/python2.7
list=./list.log

if [ ! "$1" ]; then
	echo "need input an patient name"
	exit 1
fi

$py find_key.py "$patientName" >>$list

for line in $(cat $list); do
	redis-cli  DEL $line
done

true >$list
