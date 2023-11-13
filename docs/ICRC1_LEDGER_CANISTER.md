# ICRC-1 ledger setup

## 1. Create the required identities and export initialization arguments

```bash
dfx identity new minter
dfx identity use minter
export MINTER=$(dfx identity get-principal)

export TOKEN_NAME="Internet Computer Bulgaria"
export TOKEN_SYMBOL="ICBG"

dfx identity use default
export DEFAULT=$(dfx identity get-principal)"

export PRE_MINTED_TOKENS=10_000_000_000
export TRANSFER_FEE=10_000

export ARCHIVE_CONTROLLER=$(dfx identity get-principal)
export TRIGGER_THRESHOLD=2000
export NUM_OF_BLOCK_TO_ARCHIVE=1000
export CYCLE_FOR_ARCHIVE_CREATION=10000000000000

# Specify which standards to support. If you only want to support the ICRC-1 standard then you can set:
export FEATURE_FLAGS=false
```

## 2. Deploy the ICRC-1 ledger canister locally 🚀

```bash
dfx deploy icrc1_ledger_canister --specified-id mxzaz-hqaaa-aaaar-qaada-cai --argument "(variant {Init = 
record {
      token_symbol = \"${TOKEN_SYMBOL}\";
      token_name = \"${TOKEN_NAME}\";
      minting_account = record { owner = principal \"${MINTER}\" };
      transfer_fee = ${TRANSFER_FEE};
      metadata = vec {};
      feature_flags = opt record{icrc2 = ${FEATURE_FLAGS}};
      initial_balances = vec { record { record { owner = principal \"${DEFAULT}\"; }; ${PRE_MINTED_TOKENS}; }; };
      archive_options = record {
          num_blocks_to_archive = ${NUM_OF_BLOCK_TO_ARCHIVE};
          trigger_threshold = ${TRIGGER_THRESHOLD};
          controller_id = principal \"${ARCHIVE_CONTROLLER}\";
          cycles_for_archive_creation = opt ${CYCLE_FOR_ARCHIVE_CREATION};
      };
  }
})"
```

Specifying the canister id `mxzaz-hqaaa-aaaar-qaada-cai` is optional. It is set in this tutorial, so that we can be sure what we mean when referencing the deployed canister later in this tutorial.

A more exhaustive description of interacting with ICRC-1 ledgers can be found in [this guide](https://internetcomputer.org/docs/current/developer-docs/integrations/icrc-1/interact-with-ICRC-1-ledger). 📘

Original Documentation - [ICRC-1 ledger setup](https://internetcomputer.org/docs/current/developer-docs/integrations/icrc-1/icrc1-ledger-setup)