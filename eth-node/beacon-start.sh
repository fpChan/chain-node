#!/bin/bash

/usr/local/bin/beacon-chain generate-auth-secret

/usr/local/bin/beacon-chain \
    --accept-terms-of-use \
    --execution-endpoint=http://eth:22314 \
    --jwt-secret=/data/prysm/jwt.hex \
    --checkpoint-sync-url=https://beaconstate.info \
    --genesis-beacon-api-url=https://beaconstate.info \
    --datadir /data/beacondata
