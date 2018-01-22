#! /bin/bash

# func: init ruby docker images
# date: 2016-11-17
# author: zhouwei
# email: xiaomao361@163.com
# modify: 2018-01-03 make it easy

source /etc/profile
cd /home&&bundle install
cp -f -r /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
