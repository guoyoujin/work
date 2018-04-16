#!/bin/bash
# func: set the container name and port to etcd
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com
# modify: 2018-06-16

cacert=/etc/confd/ssl/etcd-root-ca.pem
cert=/etc/confd/ssl/etcd.pem
key=/etc/confd/ssl/etcd-key.pem
etcd_url="https://47.93.243.215.com:2379"
etcd_key="wechathimsapi"

# delte the key upstream
curl --cacert $cacert --cert $cert --key $key $etcd_url/v2/keys/$etcd_key?recursive=true -XDELETE

docker ps -a | grep wechathimsapi_app_* | while read line; do
	app_key=$(echo $line | awk '{print $NF}')
	app_value=$(echo $line | awk '{print $(NF-1)}' | cut -d ':' -f 2 | cut -d '-' -f 1)
	curl --cacert $cacert --cert $cert --key $key $etcd_url/v2/keys/$etcd_key/$app_key -XPUT -d value="$app_value"
done
