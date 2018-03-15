#!/bin/bash

# date: 2018-03-15
# author: zhouwei
# email: xiaomao361@163.com
# func: deploy the hole project

HOME=
BIN=$HOME/dcm4che/bin
scp=pi@192.168.1.138:11112

$BIN/storescp -b $scp --directory $HOME/dicom
