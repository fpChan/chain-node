#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo or log in as the root user."
    exit 1
fi

# Define Bitcoin Core version
BITCOIN_VERSION="26.1"
BITCOIN_DIST="bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz"
#https://bitcoincore.org/bin/bitcoin-core-26.1/bitcoin-26.1-x86_64-linux-gnu.tar.gz

# Prompt user for RPC credentials
read -p "Enter your RPC username: " rpcuser
read -s -p "Enter your RPC password: " rpcpassword
echo

# Ask user if they want to enable external RPC access
read -p "Do you want to enable external RPC access? (yes/no): " enable_rpc

rpcallowip="127.0.0.1" # Default to localhost

if [[ $enable_rpc == "yes" ]]; then
    rpcallowip="0.0.0.0/0" # Allow all IPs (be cautious with this setting)
fi

# Update system
sudo apt update

# Install dependencies
sudo apt install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
sudo apt install -y libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev

# Download Bitcoin Core and signatures
wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/${BITCOIN_DIST}

# Install Bitcoin Core
tar -xzvf ${BITCOIN_DIST}
sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-${BITCOIN_VERSION}/bin/*

# Create Bitcoin data directory
mkdir -p ~/.bitcoin



# Create bitcoin.conf file
cat >~/.bitcoin/bitcoin.conf <<EOF
server=1
rpcuser=$rpcuser
rpcpassword=$rpcpassword
rpcallowip=$rpcallowip
rpcbind=0.0.0.0
rpcport=8332
listen=1
daemon=1
txindex=1
EOF


# Create the systemd service file for bitcoind
cat >/etc/systemd/system/bitcoind.service <<EOF
[Unit]
Description=Bitcoin daemon
After=network.target

[Service]
ExecStart=/usr/local/bin/bitcoind -daemon -conf=/root/.bitcoin/bitcoin.conf -pid=/root/.bitcoin/bitcoind.pid
User=root
Group=root
Type=forking
PIDFile=/root/.bitcoin/bitcoind.pid
Restart=on-failure
RestartSec=5
KillMode=process

[Install]
WantedBy=multi-user.target
EOF


# Reload the systemd manager configuration
systemctl daemon-reload

# Enable the bitcoind service to start on boot
systemctl enable bitcoind.service

# Start the bitcoind service now
systemctl start bitcoind.service

echo "Bitcoin Core is now installed and running."