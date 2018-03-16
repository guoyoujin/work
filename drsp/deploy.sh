#!/bin/bash

# date: 2018-03-15
# author: zhouwei
# email: xiaomao361@163.com
# func: deploy the hole project

HOME=/home/pi
BIN=$HOME/dcm4che/bin
SCP=pi@192.168.1.138:11112
LOG=$HOME/receive.log

nohup $BIN/storescp -b $SCP --directory $HOME/dicom >> $LOG &
nohup $HOME/drsp/storescu.sh &
