#!/usr/bin/env bash

## Creates an API listener process for the Daedalus wallet on Linux (tested on Ubuntu 20.04.4 LTS)
## API documentation: https://input-output-hk.github.io/cardano-wallet/api/edge/

## Requirements
	## latest version of linux cardano-wallet
	# https://github.com/input-output-hk/cardano-wallet/releases/latest
	
	## running instance of Daedalus wallet
	# https://daedaluswallet.io/en/download/

### START CUSTOMIZE ###
CARDANO-WALLET_PATH="$HOME/cardano-wallet-v2022-01-18-linux64"
WALLET_DB_PATH="/home/$USER/.local/share/Daedalus/mainnet/wallets"
API_LISTEN_IP="127.0.0.1"
API_PORT="8090"
### END CUSTOMIZE ###

# Add cardano-wallet directory to PATH environment variable
PATH="$PATH:$CARDANO-WALLET_PATH"

# Set cardano-node socket path that Daedalus is using
CARDANO_NODE_SOCKET_PATH=`ps auxwww | grep -v grep | grep cardano-wallet | grep mainnet | sed -E 's/(.*)node-socket //'`

# Start API listener
cardano-wallet serve --port $API_PORT --mainnet --listen-address $API_LISTEN_IP \
--node-socket $CARDANO_NODE_SOCKET_PATH --database $WALLET_DB_PATH
