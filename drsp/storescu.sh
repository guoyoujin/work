#!/bin/bash

# date: 2017-08-11
# author: zhouwei
# email: xiaomao361@163.com
# modify: 2018-03-15
#         modify to check a path dicom and send

HOME=
LOG=$HOME/drsp/drsp.log
CHECK=$HOME/dicom
TMP=$HOME/tmp
server_path=center@10.8.0.1:11112

source ./shellog.sh
check_one() {
	status=$(cd $local_path/$(date +'%Y%m%d') && du | sed -n '$p' | awk '{print $1}')
	info "check_one_status:" $status
	sleep 5
	retval=$(cd $local_path/$(date +'%Y%m%d') && du | sed -n '$p' | awk '{print $1}')
	echo "[info:$(date +'%Y-%m-%d %H:%M:%S')]:retval:" $retval
	let "result=$retval-$status"
	echo "[info:$(date +'%Y-%m-%d %H:%M:%S')]:result:" $result
	if [ "$result" -lt 1024 ]; then
		echo "[info:$(date +'%Y-%m-%d %H:%M:%S')]:file status not change keep watching..."
	else
		echo "[info:$(date +'%Y-%m-%d %H:%M:%S')]:file seding go to check_two "
		check_two
	fi
}

check_two() {
	status1=$(cd $local_path/$(date +'%Y%m%d') && du | sed -n '$p' | awk '{print $1}')
	echo "[info:$(date +'%Y-%m-%d %H:%M:%S')]:check_two_status1:" $status1
	sleep 30
	status2=$(cd $local_path/$(date +'%Y%m%d') && du | sed -n '$p' | awk '{print $1}')
	echo -e "[info:$(date +'%Y-%m-%d %H:%M:%S')]:check_two_status2: $status2\n"
	if [ "$status1" == "$status2" ]; then
		upload_file
		check_three $status2
		# take a look during files uploading, if there are others files sending or sended already
	else
		check_two
		# while the files is sending, make sure it will not break from panduan.
	fi
}

check_three() {
	retval=$1
	status3=$(cd $local_path/$(date +'%Y%m%d') && du | sed -n '$p' | awk '{print $1}')
	if [ "$status3" == $retval ]; then
		echo -e "\033[32m [success:] \033[0m" 'upload success, back to check_one'
		echo "[info:$(date +'%Y-%m-%d %H:%M:%S')] file no change while uploading..."
	else
		echo $(date +'%Y-%m-%d %H:%M:%S')
		echo -e "\033[32m [success:] \033[0m upload success"
		echo -e "\033[33m [warn:] \033[0m file changed while uploading"
		check_two
	fi
}

upload_file() {
	/usr/bin/rsync -avrc $local_path/$(date +'%Y%m%d') $server_path
}

main() {
	while true; do
		echo "----start:$(date +'%Y-%m-%d %H:%M:%S')---"
		if [ -d "$local_path/$(date +'%Y%m%d')" ]; then
			check_one
		else
			echo "no patient yet keep watching"
			sleep 30
		fi
		echo -e "----end:$(date +'%Y-%m-%d %H:%M:%S')-----\n"
	done
}

#main >> $logfile
main
