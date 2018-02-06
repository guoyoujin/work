#! /bin/bash
# date: 2018-02-05
# author: zhouwei
# email: xiaomao361@163.com
# func: start the geth client
 
home=/home/geth
data_path=$home/data0
networkid=2623
identity="zhouwei"
bootnodes="enode://7bebecbb0a0240aae6ba213050e9bd8f07fcbf72047b9fcd32f849c23acd39d49fb8599e7ae774dca7f6ad2a8ed60ff2c1d39040302feda92cbd84ba32eb08c1@47.93.160.139:30303"

geth --datadir $home/data0 init $home/genesis.json

geth --identity $identity \
     --datadir $data_path \
     --networkid $networkid  \
     --rpc \
     --rpcport "8545" \
     --rpcapi "personal, db, eth, net, web3, miner" \
     --rpcaddr  "0.0.0.0" \
     --port "30303" \
     --bootnodes $bootnodes 
