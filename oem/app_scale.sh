#!/bin/bash
# func: set the container name and port to etcd
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com
# modify: 2018-01-03 change for oem project

cacert=/etc/confd/ssl/etcd-root-ca.pem
cert=/etc/confd/ssl/etcd.pem
key=/etc/confd/ssl/etcd-key.pem
etcd_url="https://47.93.243.215:2379"

if [[ "$1" == "" ]]
then
   echo "need input the project name"
   exit 1
fi

etcd_key=$1
# delte the key
curl --cacert $cacert --cert $cert --key $key  $etcd_url/v2/keys/oem/$etcd_key?recursive=true -XDELETE

# loop the container name and port
docker ps -a | grep $etcd_key | grep -v base | grep -v crond |  while read line
do
  app_key=`echo $line | awk '{print $NF}'`
  app_value=`echo $line | awk '{print $(NF-1)}' | cut -d ':' -f 2 | cut -d '-' -f 1`
  curl --cacert $cacert --cert $cert --key $key  $etcd_url/v2/keys/oem/$etcd_key/$app_key  -XPUT -d value="$app_value"
done