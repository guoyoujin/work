#!/bin/bash
# func: run confd 
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com

set -e

# check the user
if [ `id -u` -ne 0 ]
then
    echo "need root"
    exit 1
fi

confd -config-file /etc/confd/conf.d/nginx.conf.toml
