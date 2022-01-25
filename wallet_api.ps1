## Creates an API listener process for the Daedalus wallet on Windows with PowerShell
## API documentation: https://input-output-hk.github.io/cardano-wallet/api/edge/

### START CUSTOMIZE ###
$ENV:DAEDALUS_PATH="C:\Program Files\Daedalus Mainnet"
$ENV:WALLET_DB_PATH="C:\Users\<user>\AppData\Roaming\Daedalus Mainnet\wallets"
$ENV:API_LISTEN_IP="127.0.0.1"
$ENV:API_PORT="8090"
### END CUSTOMIZE ###

# Add Daedalus program path to env var
$ENV:PATH += ";$env:DAEDALUS_PATH"

# Set CARDANO_NODE_SOCKET_PATH var (changes everytime Daedalus is restarted)
$ENV:CARDANO_NODE_SOCKET_PATH = (Get-ChildItem \\.\pipe\ | Where-Object {$_.name -like "cardano-node*"}).FullName

# Start API listener
cardano-wallet serve --port $env:API_PORT --mainnet --listen-address $env:API_LISTEN_IP --node-socket $env:CARDANO_NODE_SOCKET_PATH --database $env:WALLET_DB_PATH
