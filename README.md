# Cardano Scripts
A collection of scripts for Cardano

## Powershell scripts
**submit_api.ps1** 
- Create a [Cardano Submit API](https://input-output-hk.github.io/cardano-rest/submit-api/) listening process in Windows and connect it to Daedalus. Useful for connecting light wallets like Nami to a local node.

**wallet_api.ps1** 
- Create a [Cardano Wallet API](https://input-output-hk.github.io/cardano-wallet/api/edge/) listening process in Windows and connect it to Daedalus. Allows a user to send ADA on the command line using curl and json payloads. 

## Bash scripts
**ada_cannon.sh**
- Send a series of transactions to a recipient address. Configure the number of transactions, how much ADA per transaction, and whether any ADA will be sent back. Fees are calculated and a summary is printed showing the recipient address, total cost in ADA, number of transactions, fee per transaction, amount per transaction and amount of ADA expected to be sent back per transaction. Connects to a [Cardano Wallet API](https://input-output-hk.github.io/cardano-wallet/api/edge/) listener process - see [wallet_api.ps1](wallet_api.ps1) for an example. Useful for ADA token faucets - rather than manually creating transactions one by one, you can automate as many as you want and let the script run. 
