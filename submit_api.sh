## Creates an API listener process for cardano submit API
## API documentation: https://input-output-hk.github.io/cardano-rest/submit-api/

## Requirements
	## latest cardano-submit-api executable (cardano-node package)
	# https://hydra.iohk.io/job/Cardano/cardano-node/cardano-node-linux/latest-finished

	## cardano-submit-api config file sample
	#  https://raw.githubusercontent.com/input-output-hk/cardano-node/master/cardano-submit-api/config/tx-submit-mainnet-config.yaml
	
	## running instance of Daedalus wallet
	# https://daedaluswallet.io/en/download/

### START CUSTOMIZE ###
CARDANO_SUBMIT_API_EXE="$HOME/cardano-node-1.33.0-linux/cardano-submit-api"
CARDANO_SUBMIT_CONFIG="$HOME/cardano-node-1.33.0-linux/tx-submit-mainnet-config.yaml"
API_LISTEN_IP="127.0.0.1"
API_PORT="8090"
### END CUSTOMIZE ###

LISTENER_URL="http://$API_LISTEN_IP:$API_PORT/api/submit/tx"

# Set cardano-node socket path that Daedalus is using
CARDANO_NODE_SOCKET_PATH=`ps auxwww | grep -v grep | grep cardano-wallet | grep mainnet | sed -E 's/(.*)node-socket //'`

# Echo listener url and instructions to screen
echo
echo "Copy and paste the following url into the corresponding wallets:"
echo "Nami: \"Settings -> Network -> Custom node\""
echo "CCVault: \"Preferences -> Custom Submit API Endpoint\""
echo
echo "$LISTENER_URL"
echo 

# Create Cardano submit API listener
$CARDANO_SUBMIT_API_EXE --mainnet --socket-path $CARDANO_NODE_SOCKET_PATH \
--config $CARDANO_SUBMIT_CONFIG --port $API_PORT --listen-address $API_LISTEN_IP
