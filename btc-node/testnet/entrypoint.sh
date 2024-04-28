#!/bin/bash
export PATH=/bitcoin-27.0/bin:$PATH

bitcoind -daemon --conf=/etc/bitcoin/bitcoin.conf

#sleep 200
tail -f /data/bitcoin/bitcoin-data/testnet3/debug.log