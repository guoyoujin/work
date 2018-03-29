#!/bin/bash
# func: pull code and run meeting container with 3 app
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com
# modify: 2018-03-19:
#         2018-03-20: copy from echeck use for meeting

script_home=/home/tongxin/oem/meeting

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
su - tongxin -c "cd $script_home/txmeeting && git pull origin master"
if [ $? -ne 0 ]; then
	echo "code pull error"
	exit 1
fi

# check the home path
if [ $(pwd)!=="$script" ]; then
	cd $script_home
fi

compose() {
	name=$1
	docker-compose stop $name
	docker-compose rm -f $name
	docker-compose up -d $name
}

# docker-compose build and up
docker-compose build
if [ $? -eq 0 ]; then
	$script_home/app_scale.sh crond # scale the base port to the nginx conf

	# restart app
	docker-compose scale app=1
	compose app
	docker-compose scale app=3

	echo "waiting for 5min fo echeck app start ready"
	sleep 300

	$script_home/app_scale.sh app # scale the app ports to the nginx conf

	compose crond
	compose base

else
	echo "docker-compose build base error"
fi
