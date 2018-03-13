#!/bin/bash
# func: set the container name and port to etcd
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com
# modify: 2018-01-03 change for oem project
#         2018-03-08 add project type for hot deploy

cacert=/etc/confd/ssl/etcd-root-ca.pem
cert=/etc/confd/ssl/etcd.pem
key=/etc/confd/ssl/etcd-key.pem
etcd_url="https://47.93.243.215:2379"

if [[ "$1" == "" ]]; then
	echo "need input the project name"
	exit 1
fi

project_type=$1
etcd_key=$2

# delte the key
curl --cacert $cacert --cert $cert --key $key $etcd_url/v2/keys/oem/$etcd_key?recursive=true -XDELETE

# check the type for add the right app ports to etcd
if [ ${project_type} == "base" ]; then
	app_key=${etcd_key}_base
	app_value=$(docker ps -a | grep ${project_name} | grep base | awk '{print $(NF-1)}' | cut -d ':' -f 2 | cut -d '-' -f 1)
	curl --cacert $cacert --cert $cert --key $key $etcd_url/v2/keys/oem/$etcd_key/$app_key -XPUT -d value="$app_value"
elif [ ${project_type} == "app" ]; then
	docker ps -a | grep $etcd_key | grep -v base | grep -v crond | while read line; do
		app_key=$(echo $line | awk '{print $NF}')
		app_value=$(echo $line | awk '{print $(NF-1)}' | cut -d ':' -f 2 | cut -d '-' -f 1)
		curl --cacert $cacert --cert $cert --key $key $etcd_url/v2/keys/oem/$etcd_key/$app_key -XPUT -d value="$app_value"
	done
else
	echo "$project_type undefine used app|base project_name"
  exit 1
fi
