#!/bin/bash

# date: 2017-08-11
# author: zhouwei
# email: xiaomao361@163.com
# modify: 2018-03-15
#         modify to check a path dicom and send

HOME=/home/pi
LOG=$HOME/drsp.log
CHECK=$HOME/dicom
TMP=$HOME/tmp
BIN=$HOME/dcm4che/bin
server_path=center@10.8.0.1:11112

source $HOME/drsp/shellog.sh

receive_check() {
	file_size=$(cd $CHECK && du | sed -n '$p' | awk '{print $1}')
	info "1: file size:" $file_size
	sleep 5
	compare_size=$(cd $CHECK && du | sed -n '$p' | awk '{print $1}')
	info "1: compare size:" $compare_size
	let "result=$compare_size-$file_size"
	info "1: result:" $result
	if [ "$result" -lt 1024 ]; then
		info "1: file size not change keep watching..."
	else
		success "1: receiveing dicom images now go to  "
		size_check
	fi
}

size_check() {
	file_size=$(cd $CHECK && du | sed -n '$p' | awk '{print $1}')
	info "2: file size:" $file_size
	sleep 30
	compare_size=$(cd $CHECK && du | sed -n '$p' | awk '{print $1}')
	info "2: compare size:" $compare_size
	if [ "$status1" == "$status2" ]; then
        mv $CHECK/* $TMP
		scu
		backup_check $compare_size
		# take a look during files uploading, if there are others files sending or sended already
	else
		size_check
		# while the files is sending, make sure it will not break from panduan.
	fi
}

backup_check() {
	compare_size=$1
	file_size=$(cd $CHECK && du | sed -n '$p' | awk '{print $1}')
	if [ "$file_size" == $compare_size ]; then
		success "upload success, back to receive_check"
		info "file size not change while sending..."
	else
		echo $(date +'%Y-%m-%d %H:%M:%S')
		success "upload success"
		warn "file changed while sending..."
		size_check
	fi
}

scu() {
    cd $HOME
	$BIN/storescu -c $server_path $TMP
}

main() {
	while true; do
		echo "----start:$(date +'%Y-%m-%d %H:%M:%S')---"
        size=$(cd $CHECK && du | sed -n '$p' | awk '{print $1}')
		if [ $size -ne 0 ]; then
			receive_check
		else
			echo "no patient yet keep watching"
			sleep 30
		fi
		echo -e "----end:$(date +'%Y-%m-%d %H:%M:%S')-----\n"
	done
}

main >> $LOG
