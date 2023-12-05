#!/bin/bash

# Stop the script if any command fails
set -e

# Define a function to log messages
log() {
  echo "=> $1"
}

dfx identity use minter
export MINTER=$(dfx identity get-principal)

log "Setting token name and symbol"
export TOKEN_NAME="Chain-key Bitcoin"
export TOKEN_SYMBOL="ckBTC"

log "Setting initial balance wallet"
export INITIAL_BALANCE_WALLET="c6icq-mj2yd-ss2ea-3qhtb-mob5w-2jmau-hu7bs-zw2wi-2juqh-wmgxz-wae"

log "Switching back to default identity"
dfx identity use default

log "Setting token parameters"
export PRE_MINTED_TOKENS=10_000_000_000
export TRANSFER_FEE=10_000

log "Setting archive parameters"
export ARCHIVE_CONTROLLER=$(dfx identity get-principal)
export TRIGGER_THRESHOLD=2000
export NUM_OF_BLOCK_TO_ARCHIVE=1000
export CYCLE_FOR_ARCHIVE_CREATION=10000000000000

log "Setting feature flags"
export FEATURE_FLAGS=false

log "Deploying the ICRC-1 ledger canister"
dfx deploy icrc1_ledger_canister --mode reinstall --specified-id mxzaz-hqaaa-aaaar-qaada-cai --argument "(variant {Init = 
record {
      token_symbol = \"${TOKEN_SYMBOL}\";
      token_name = \"${TOKEN_NAME}\";
      minting_account = record { owner = principal \"${MINTER}\" };
      transfer_fee = ${TRANSFER_FEE};
      metadata = vec {};
      feature_flags = opt record{icrc2 = ${FEATURE_FLAGS}};
      initial_balances = vec { record { record { owner = principal \"${INITIAL_BALANCE_WALLET}\"; }; ${PRE_MINTED_TOKENS}; }; };
      archive_options = record {
          num_blocks_to_archive = ${NUM_OF_BLOCK_TO_ARCHIVE};
          trigger_threshold = ${TRIGGER_THRESHOLD};
          controller_id = principal \"${ARCHIVE_CONTROLLER}\";
          cycles_for_archive_creation = opt ${CYCLE_FOR_ARCHIVE_CREATION};
      };
  }
})"

log "ICRC-1 ledger setup is complete"