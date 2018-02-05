#! /bin/bash

home=~/unimed_block_chain
data_path=$home/data0
geth=$home/geth
networkid=2623
identity="unimed"

$geth --identity $identity \
      --datadir $data_path \
      --networkid $networkid  \
      --nodiscover \ 
      --rpc \
      --rpcport "8545" \
      --rpcapi "personal, db, eth, net, web3, miner" \ 
      --rpcaddr "0.0.0.0" \ 
      --port "30303" console