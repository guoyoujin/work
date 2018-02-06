#! /bin/bash
# date: 2018-02-05
# author: zhouwei
# email: xiaomao361@163.com
# func: init and start the geth server
 
home=/home/geth
data_path=$home/data0
networkid=2623
identity="zhouwei"
log=$home/geth.log

geth --datadir $home/data0 init $home/genesis.json

geth --identity $identity \
     --datadir $data_path \
     --networkid $networkid  \
     --nodiscover \
     --rpc \
     --rpcport "8545" \
     --rpcapi "personal, db, eth, net, web3, miner" \
     --rpcaddr  "0.0.0.0" \
     --port "30303" 
