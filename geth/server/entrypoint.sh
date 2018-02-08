#! /bin/bash
# date: 2018-02-05
# author: zhouwei
# email: xiaomao361@163.com
# func: init and start the geth server

home=/home/geth
data_path=$home/data0
networkid=2623
identity="unimed"
log=$home/geth.log

if [ $(ls -A $data_path | wc -l) -eq 0 ]; then
	geth --datadir $home/data0 init $home/genesis.json
fi

geth --identity $identity \
	--datadir $data_path \
	--networkid $networkid \
	--nodiscover \
	--rpc \
	--rpcport "8545" \
	--rpcapi "personal, db, eth, net, web3, miner" \
	--rpcaddr "0.0.0.0" \
	--port "30303"
