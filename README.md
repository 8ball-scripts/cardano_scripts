# Cardano Scripts
A collection of scripts for creating Cardano transactions

## Bash scripts
**[submit_api.sh](submit_api.sh)** 
- Create a [Cardano Submit API](https://input-output-hk.github.io/cardano-rest/submit-api/) listening process in Linux and connect it to [Daedalus wallet](https://daedaluswallet.io/). Useful for connecting light wallets like Nami or CCVault to a local node (Daedalus) rather than relying on external light wallet servers which can become congested or go offline. Windows powershell version is avaialable in [submit_api.ps1](submit_api.ps1)

**[wallet_api.sh](wallet_api.sh)** 
- Create a [Cardano Wallet API](https://input-output-hk.github.io/cardano-wallet/api/edge/) listening process in Linux and connect it to [Daedalus wallet](https://daedaluswallet.io/). Allows a user to send ADA on the command line using curl with json payloads. See [ada_cannon.sh](ada_cannon.sh) for how to connect to the Wallet API and create transactions. Windows powershell version is avaialable in [wallet_api.ps1](wallet_api.ps1)

**[ada_cannon.sh](ada_cannon.sh)**
- Send a series of transactions to a recipient address. Configure the number of transactions, how much ADA per transaction, and whether any ADA will be sent back. A pre-transaction summary is printed showing the recipient address, number of transactions, fee per transaction, amount per transaction, amount of ADA expected to be sent back per transaction, and total cost in ADA. Connects to a [Cardano Wallet API](https://input-output-hk.github.io/cardano-wallet/api/edge/) listener process using curl json API payloads - see [wallet_api.sh](wallet_api.sh) or [wallet_api.ps1](wallet_api.ps1) for an example of how to create a Wallet API listener. Useful for ADA token faucets - rather than manually creating transactions one by one, you can quickly automate as many as you want and let the script run without any further interaction. Can also be used to send a single transaction - just set transactions variable to "1". 

## Powershell scripts
**[submit_api.ps1](submit_api.ps1)** 
- Create a [Cardano Submit API](https://input-output-hk.github.io/cardano-rest/submit-api/) listening process in Windows and connect it to [Daedalus wallet](https://daedaluswallet.io/). Useful for connecting light wallets like Nami or CCVault to a local node (Daedalus) rather than relying on external light wallet servers which can become congested or go offline. Linux version is avaialable in [submit_api.sh](submit_api.sh)

**[wallet_api.ps1](wallet_api.ps1)** 
- Create a [Cardano Wallet API](https://input-output-hk.github.io/cardano-wallet/api/edge/) listening process in Windows and connect it to [Daedalus wallet](https://daedaluswallet.io/). Allows a user to send ADA on the command line using curl with json payloads. See [ada_cannon.sh](ada_cannon.sh) for how to connect to the Wallet API and create transactions. Linux version is avaialable in [wallet_api.sh](wallet_api.sh)

## Reference Documentation
[Cardano Wallet API documentation](https://input-output-hk.github.io/cardano-wallet/api/edge/)<br>
[Cardano Submit API documentation](https://input-output-hk.github.io/cardano-rest/submit-api/)<br>
[Cardano Submit API config file example](https://raw.githubusercontent.com/input-output-hk/cardano-node/master/cardano-submit-api/config/tx-submit-mainnet-config.yaml)<br>
[Cardano Submit API executable latest Linux binary](https://hydra.iohk.io/job/Cardano/cardano-node/cardano-node-linux/latest-finished)<br>
[Cardano Submit API executable latest Windows binary](https://hydra.iohk.io/job/Cardano/cardano-node/cardano-node-win64/latest-finished)<br>
[Daedalus Wallet](https://daedaluswallet.io/)<br>

## Donations
Found these scripts useful? Buy me a coffee by donating some ADA to the following address:
`addr1vx0hn58q5dql783rzakayepg0akhkldmeqwlaz7mqrwmv3cuvxv2g`
