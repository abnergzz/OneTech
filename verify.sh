#!/bin/bash

TOKEN=$1
VALUE1=$(base64 <<< $2)
VALUE2=$(base64 <<< $3)
VALUE3=$(base64 <<< $4)

grep hmac results.json > validate.txt
mapfile -t array < validate.txt

cat << EOF > payload.json
{
    "batch_input": [
      {
        "input": "$VALUE1",
        ${array[0]}
      },
      {
        "input": "$VALUE2",
        ${array[1]}
      },
      {
        "input": "$VALUE3",
        ${array[2]}
      }
    ]
}
EOF

curl  --header "X-Vault-Token: $TOKEN" --request POST --data @payload.json --silent http://34.219.135.154:8200/v1/transit/verify/one-tech/sha2-512 | jq ".data.batch_results"

