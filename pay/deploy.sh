#!/bin/bash
# func: pull code and run pay container
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com
# modify: 2018-03-25: change for txpay

script_home=/home/tongxin/pay

set -e

# check the user
if [ $(id -u) -ne 0 ]; then
	echo "need root"
	echo "use sudo ./deploy.sh"
	exit 1
fi

# check docker network
docker network ls | grep backend || docker network create backend

# pull code
su - tongxin -c "cd $script_home/txpay&&git pull origin master"
if [ $? -ne 0 ]; then
	echo "code pull error"
	exit 1
fi

# check the home path
if [ $(pwd)!=="$script" ]; then
	cd $script_home
fi

# docker-compose build and up
docker-compose build
if [ $? -eq 0 ]; then
	docker-compose down
    docker-compose up -d 
else
	echo "docker-compose build base error"
fi
