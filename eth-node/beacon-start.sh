#!/bin/bash

/usr/local/bin/beacon-chain generate-auth-secret
# Sleep for 10 seconds to allow eth service to fully start
sleep 30

/usr/local/bin/beacon-chain \
    --accept-terms-of-use \
    --execution-endpoint=http://eth:8551 \
    --jwt-secret=/data/prysm/jwt.hex \
    --checkpoint-sync-url=https://sync.invis.tools \
    --genesis-beacon-api-url=https://sync.invis.tools \
    --datadir /data/beacondata \
    --rpc-host=0.0.0.0 \
    --grpc-gateway-host=0.0.0.0