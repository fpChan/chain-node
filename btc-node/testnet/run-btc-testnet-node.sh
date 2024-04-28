docker build -t my-bitcoin-node .
docker run -d -p 18332:18332 -v /data/btc-test-node/test-chain-data:/data/bitcoin/bitcoin-data --name btc-testnet-node my-bitcoin-node
