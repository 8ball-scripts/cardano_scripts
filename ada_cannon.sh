#!/usr/bin/env bash

# script to automate sending transactions through the cardano-wallet API listener
# API documentation: https://input-output-hk.github.io/cardano-wallet/api/edge/

# for testing - don't submit transactions if dry_run value is "1" - just show summary and quit
dry_run="0"

## CONFIG BEGIN ##
recipient_address="<recipient address>"
# how much ada to send in each transaction
amount="2"
# get wallet id with "curl http://<ip>:8090/v2/wallets | jq ."
wallet_id="<your wallet id>"
wallet_passphrase='<your wallet spend password>'
# will recpient send ADA back? If not, set ada_return value to "0"
ada_return="1.5"
# how many transactions in the batch?
transactions="10"
sec_delay_between_transactions="2"
proto="http"
host="<cardano wallet api listener IP address>"
port="8090"
## CONFIG END ##

api_path="v2/wallets"
api_endpoint="transactions"

lovelace_amount=`awk "BEGIN {print ($amount*1000000)}"`
url="$proto://$host:$port"

## optional prompt for variable values
# read -p 'Recipient address: ' recipient_address
# read -p 'Amount of ADA to send: ' amount
# read -p 'Wallet passsword: ' wallet_passphrase

payload() {
  cat <<EOF
{
    "payments": [
        {
            "address": "$recipient_address",
            "amount": {
                "quantity": $lovelace_amount,
                "unit": "lovelace"
            }
        }
    ],
    "passphrase": "$wallet_passphrase",
    "withdrawal": "self"
}
EOF
}

## get fee amount from API
fee=`curl -s --connect-timeout 2 --location \
--request POST "$url/$api_path/$wallet_id/payment-fees" \
--header 'Content-Type: application/json' \
--data-raw "$(payload)"`
exit_status=$?
if [[ $exit_status != 0 ]]; then
	echo
	echo "curl failed to connect to the API (error code #$exit_status)"
	echo "curl error code details: https://everything.curl.dev/usingcurl/returns"
	echo "aborting script!"
	echo
	exit 1
fi
fee_json=`echo "$fee" | jq '.estimated_min.quantity'`
fee_float=`awk "BEGIN {print ($fee_json/1000000)}"`

## show summary of trasaction and ask for confirmation
echo
echo "=================================================================="
echo "Sending to: $recipient_address"
echo "Number of transactions: $transactions"
echo "ADA per transaction: $amount"
echo "Total ADA being sent for all transactions: `awk "BEGIN {print ($amount*$transactions)}"`"
echo "Delay in secs between transactions: $sec_delay_between_transactions"
echo "Fee per transaction: $fee_float"
echo "ADA being sent back per transaction: $ada_return"
echo "Final ADA cost for batch after recipient return(s): \
`awk "BEGIN {print ($amount*$transactions)-($transactions*$ada_return)+($fee_float*$transactions)}"`"
echo "=================================================================="
echo
read -p "Review summary above. Begin batch? (Y/N): "
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then\
	echo "Script aborted!"
	echo
    exit 1
fi
echo
echo "Prepare the ADA cannon...fire!!"
echo

## send transactions to API
if [[ $dry_run != 1 ]]; then
	for (( i = 1; i <= $transactions; i++ )); do
		echo "transaction: $i of $transactions"
		echo "sending $amount ADA ($lovelace_amount lovelace)"
		curl --location --request POST "$url/$api_path/$wallet_id/$api_endpoint" \
		--header 'Content-Type: application/json' \
		--data-raw "$(payload)"
		sleep $sec_delay_between_transactions
		echo
		echo
	done
else
	echo "dry-run enabled, transactions will not be sent!"
	echo
fi
