#! /bin/bash
# date: 2018-02-05
# author: zhouwei
# email: xiaomao361@163.com
# func: start the geth client
 
home=/home/geth
data_path=$home/data0
networkid=2623
identity="zhouwei"

geth --identity $identity \
     --datadir $data_path \
     --networkid $networkid  \
     --nodiscover \
     --rpc \
     --rpcport "8545" \
     --rpcapi "personal, db, eth, net, web3, miner" \
     --rpcaddr  "0.0.0.0" \
     --port "30303" \
     --bootnodes "${BOOTNODES}"
     console
