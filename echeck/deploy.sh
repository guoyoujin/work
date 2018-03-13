#!/bin/bash
# func: pull code and run echeck container with 3 app
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com

script_home=/home/tongxin/echeck

set -e

# check the user 
if [ `id -u` -ne 0 ]
then
    echo "need root"
    echo "use sudo ./deploy.sh"
    exit 1
fi

# pull code 
su - tongxin -c "cd $script_home/txpatient&&git pull origin master"
if [ $? -ne 0 ]
then
    echo "code pull error"
    exit 1
fi

# check the home path
if [ `pwd`!=="$script" ]
then
   cd $script_home
fi

# docker-compose build and up
docker-compose build
if [ $? -eq 0 ]
then
    docker-compose down
    docker-compose up -d 
    docker-compose scale app=3
    $script_home/app_scale.sh
else
    echo "docker-compose build base error"
fi


