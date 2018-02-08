#! /bin/bash
# date: 2018-02-05
# author: zhouwei
# email: xiaomao361@163.com
# func: start the geth client

home=/home/geth
data_path=$home/data0
networkid=2623
identity="unimed"
bootnodes="enode://539928e9d25db9e8af4521c320863a9c646beec0241b6e5bb6986b8b2a7ced234921857a69b9af824f0fda603efedbf7fdb77c22e21c7830836e2812cf92aa17@47.93.160.139:30303"

if [ $(ls -A $data_path | wc -l) -eq 0 ]; then
	geth --datadir $home/data0 init $home/genesis.json
fi

geth --identity $identity \
	--datadir $data_path \
	--networkid $networkid \
	--rpc \
	--rpcport "8545" \
	--rpcapi "personal, db, eth, net, web3, miner" \
	--rpcaddr "0.0.0.0" \
	--port "30303" \
	--bootnodes $bootnodes
