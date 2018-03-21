#!/bin/bash
# func: pull code and run oem project container
# date: 2018-01-03
# author: zhouwei
# email: xiaoamo361@163.com
# modify: 2018-03-07: change for hot deploy
# 	      2018-03-21: modify the script for deploy all the project

script_home=/home/tongxin/oem
project_name=$1

# check the user
if [ $(id -u) -ne 0 ]; then
	echo "need root"
	echo "use sudo ./deploy.sh"
	exit 1
fi

run_deploy() {
	project=$1
	cd $script_home/$project && ./deploy.sh
}

case $1 in
diagnose)
	run_deploy diagnose
	;;
hims)
	run_deploy hims
	;;
hiapi)
	run_deploy hiapi
	;;
manager)
	run_deploy manager
	;;
meeting)
	run_deploy meeting
	;;

*)
	echo "need input the project name { diagnose|hims|hiapi|manager|meeting}"
	exit 1
	;;
esac
