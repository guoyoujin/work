#!/bin/bash

#file=/etc/openvpn/openvpn-status.log
file=./app/test.log

arg=$1
ae=`echo ${arg}|awk '{print $1}'`
host=`echo ${arg}|awk '{print $2}'`
port=`echo ${arg}|awk '{print $3}'`


check_dicom(){
    ae=$1
    host=$2
    port=$3
    echoscu -aet ${ae} ${host} ${port}
    if [ $? -eq 0 ];
    then
        echo "dicom support"
            return 0
        else
            echo "dicom not support"
            return 1
     fi
}

cat ${file} | grep ${host}

if [ $? -eq 0 ];
then
    echo "vpn is fine , check dicom support"
    check_dicom ${ae} ${host} ${port}
else
    echo "host not in file, ping $host"
#    ping -c 3 ${host}
#    if [ $? -eq 0 ];
#    then
#        check_dicom ${ae} ${host} ${port}
#    else
#        echo "host not alive"
#        exit 1
#    fi
    exit 1
fi


