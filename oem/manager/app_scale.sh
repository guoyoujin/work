#!/bin/bash
# func: set the container name and port to etcd
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com
# modify: 2018-03-19
#         2018-03-20: copy from echeck use for manager

cacert=/etc/confd/ssl/etcd-root-ca.pem
cert=/etc/confd/ssl/etcd.pem
key=/etc/confd/ssl/etcd-key.pem
etcd_url="https://47.93.243.215:2379"
etcd_key="manager"

# delte the key upstream
curl --cacert $cacert --cert $cert --key $key $etcd_url/v2/keys/$etcd_key?recursive=true -XDELETE

app_type=$1
if [ "$app_type" = "crond" ]; then
	curl --cacert $cacert --cert $cert --key $key $etcd_url/v2/keys/$etcd_key/manager_crond -XPUT -d value="8004"
elif [ "$app_type" = "app" ]; then
	# loop the container name and port
	docker ps -a | grep manager_app_* | while read line; do
		app_key=$(echo $line | awk '{print $NF}')
		app_value=$(echo $line | awk '{print $(NF-1)}' | cut -d ':' -f 2 | cut -d '-' -f 1)
		curl --cacert $cacert --cert $cert --key $key $etcd_url/v2/keys/$etcd_key/$app_key -XPUT -d value="$app_value"
	done
else
	echo "use ./app_scale { app | base }"
fi
