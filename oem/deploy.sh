#!/bin/bash
# func: pull code and run oem project container
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com
# modify: 2018-03-07: change for hot deploy

script_home=/home/tongxin/oem
project_name=$1

# check input
if [[ "$1" == "" ]]; then
	echo "need input the project name { diagnose|hims|hiapi|manager|meeting}"
	exit 1
fi

# check the user
if [ $(id -u) -ne 0 ]; then
	echo "need root"
	echo "use sudo ./deploy.sh"
	exit 1
fi

# pull code
su - tongxin -c "cd $script_home/$project_name/tx${project_name}&&git pull origin master"
if [ $? -ne 0 ]; then
	echo "code pull error"
	exit 1
fi

# check the home path
if [ $(pwd)!=="$script" ]; then
	cd $script_home
fi

# build the new version images
docker-compose build ${project_name}_base
docker-compose build ${project_name}_crond
docker-compose build ${project_name}

if [ $? -eq 0 ]; then
	# change the nginx conf file to base ports for servers
	$script_home/app_scale.sh "base" ${project_name}

	# deploy the new version project
	docker-compose scale ${project_name}=1
	docker-compose stop ${project_name}
	docker-compose rm -f ${project_name}
	docker-compose up -d ${project_name}
	docker-compose scale ${project_name}=3

	# test the project start status and if something wrong exit the script
	project_base_port=$(docker ps -a | grep ${project_name} | grep base | awk '{print $(NF-1)}' | cut -d ':' -f 2 | cut -d '-' -f 1)
	curl localhost:${project_base_port} && $script_home/app_scale.sh "app" ${project_name} || echo "project curl error" && exit 1

	# run the new version base and crond
	docker-compose stop ${project_name}_crond
	docker-compose rm -f ${project_name}_crond
	docker-compose stop ${project_name}_base
	docker-compose rm -f ${project_name}_base
	docker-compose up -d ${project_name}_base
	docker-compose up -d ${project_name}_crond

else
	echo "docker-compose build base error"
fi
