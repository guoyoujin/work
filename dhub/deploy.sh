#!/bin/bash
# func: pull code and run RDT project container
# date: 2018-04-04
# author: zhouwei
# email: xiaoamo361@163.com

script_home=/home/tongxin/dhub

echo "pull code"
cd $script_home/txRDTDicom && git pull origin master
cd $script_home/txRDTGearman && git pull origin master

cd $script_home
sudo docker-compose down
sudo docker-compose build
sudo docker-compose up -date
sudo docker-compose scale dicom=10
sudo docker-compose scale gearman=3
