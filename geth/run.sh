#!/bin/bash

# date: 2018-02-06
# author: zhouwei
# email: xiaomao361@163.com
# func: run an zhouwei block chain node

docker pull xiaomao361/geth_client

docker run -d --name block -p 8545:8545 -p 30303:30303 xiaomao361/geth_client
