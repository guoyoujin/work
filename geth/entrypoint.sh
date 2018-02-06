#!/bin/bash

cd /home/geth
geth --datadir ./date0 init genesis.json

if [ $1 ]
then
    /home/geth/server.sh
else
    /home/geth/client.sh
fi
