#!/bin/bash

# Stop the script if any command fails
set -e

# Define a function to log messages
log() {
  echo "=> $1"
}

dfx identity use minter
export MINTER_ACCOUNT_ID=$(dfx ledger account-id)

log "Switching back to default identity"
dfx identity use default
export DEFAULT_ACCOUNT_ID=$(dfx ledger account-id)

log "Deploying the ledger canister"
dfx deploy --mode reinstall --specified-id ryjl3-tyaaa-aaaaa-aaaba-cai icp_ledger_canister --argument "
  (variant {
    Init = record {
      minting_account = \"$MINTER_ACCOUNT_ID\";
      initial_values = vec {
        record {
          \"$DEFAULT_ACCOUNT_ID\";
          record {
            e8s = 10_000_000_000 : nat64;
          };
        };
      };
      send_whitelist = vec {};
      transfer_fee = opt record {
        e8s = 10_000 : nat64;
      };
      token_symbol = opt \"LICP\";
      token_name = opt \"Local ICP\";
    }
  })
"

log "ICP ledger local setup is complete"
