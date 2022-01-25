## Creates an API listener process for cardano submit API
## API documentation: https://input-output-hk.github.io/cardano-rest/submit-api/

### START CUSTOMIZE ###
$ENV:CARDANO_SUBMIT_API_EXE="C:\cardano-node-1.33.0-win64\cardano-submit-api.exe"
$ENV:CARDANO_SUBMIT_CONFIG="C:\cardano-node-1.33.0-win64\tx-submit-mainnet-config.yaml"
$ENV:API_LISTEN_IP="127.0.0.1"
$ENV:API_PORT="8090"
### END CUSTOMIZE ###

## INFO: Required Files ##
# cardano-node package
# https://hydra.iohk.io/job/Cardano/cardano-node/cardano-node-win64/latest-finished
# submit config file
# https://raw.githubusercontent.com/input-output-hk/cardano-node/master/cardano-submit-api/config/tx-submit-mainnet-config.yaml

$ENV:LISTENER_URL="http://$($ENV:API_LISTEN_IP):$($ENV:API_PORT)/api/submit/tx"

# Set CARDANO_NODE_SOCKET_PATH var (changes everytime Daedalus is restarted)
$ENV:CARDANO_NODE_SOCKET_PATH = (Get-ChildItem \\.\pipe\ | Where-Object {$_.name -like "cardano-node*"}).FullName

# Echo listener url to screen
echo ""
echo 'Copy and paste url into Nami "Settings -> Network -> Custom node":'
echo "$ENV:LISTENER_URL"
echo ""

# Create Cardano submit API listener
$START_LISTENER="$ENV:CARDANO_SUBMIT_API_EXE --mainnet --socket-path $ENV:CARDANO_NODE_SOCKET_PATH --config $ENV:CARDANO_SUBMIT_CONFIG --port $ENV:API_PORT --listen-address $ENV:API_LISTEN_IP"
Invoke-Expression $START_LISTENER

