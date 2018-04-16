#!/bin/bash
# func: pull code and run wechathimsapi container with 3 app
# date: 2018-04-16
# author: zhouwei
# email: xiaoamo361@163.com

script_home=/home/tongxin/wechathimsapi

set -e

# check the user
if [ $(id -u) -eq 0 ]; then
	echo "do not use root"
	echo "use  ./deploy.sh"
	exit 1
fi

# check docker network
sudo docker network ls | grep backend || docker network create backend

# pull code
cd /home/tongxin/go/src/wechatHimsAPI && git pull origin master
if [ $? -ne 0 ]; then
	echo "code pull error"
	exit 1
fi

# build 
cd /home/tongxin/go/src/wechatHimsAPI
go build -tags netgo -a -v && mv wechatHimsAPI $script_home/

# check the home path
if [ $(pwd)!=="$script" ]; then
	cd $script_home
fi

# docker-compose build and up
sudo docker-compose build
if [ $? -eq 0 ]; then

	sudo docker-compose down
	sudo docker-compose up -d
	sudo docker-compose scale app=3
    sudo $script_home/app_scale.sh
else
	echo "docker-compose build base error"
fi
