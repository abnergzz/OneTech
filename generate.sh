#!/bin/bash

TOKEN=$1
VALUE1=$(base64 <<< $2)
VALUE2=$(base64 <<< $3)
VALUE3=$(base64 <<< $4)

cat << EOF > payload.json
{
    "batch_input": [
      {
        "input": "$VALUE1"
      },
      {
        "input": "$VALUE2"
      },
      {
        "input": "$VALUE3"
      }
    ]
}
EOF

curl  --header "X-Vault-Token: $TOKEN" --request POST --data @payload.json --silent http://34.219.135.154:8200/v1/transit/hmac/one-tech/sha2-512 | jq ".data.batch_results"
