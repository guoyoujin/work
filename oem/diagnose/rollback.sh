#!/bin/bash

# date: 2018-03-07
# author: zhouwei
# func: rollback the last worked version
# email: xiaomao361@163.com
# modify: rollback for diagnose

script_home=/home/tongxin/oem/diagnose

# check the user
if [ $(id -u) -ne 0 ]; then
	echo "need root"
	echo "use sudo ./rollback.sh"
	exit 1
fi

# checkout the last worked version code
su - tongxin -c "cd $script_home/txdiagnose&&git reset --hard HEAD^"
if [ $? -ne 0 ]; then
	echo "code roll last version error"
	exit 1
fi

# check the home path
if [ $(pwd)!=="$script" ]; then
	cd $script_home
fi

docker-compose build
if [ $? -eq 0 ]; then
	docker-compose down
    docker-compose up -d 
	$script_home/app_scale.sh app
else
	echo "docker-compose build base error"
fi
