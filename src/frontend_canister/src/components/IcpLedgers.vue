<template>
  <div>ICRC Ledger ckBTC Test</div>
</template>
<script setup>
  import { IcrcLedgerCanister } from "@dfinity/ledger-icrc";
  import { createAgent } from "@dfinity/utils";
  import { useAuthStore } from "../store/auth";

  const authStore = useAuthStore();
  
  const agent = await createAgent({
    identity: authStore.identity,
    host: "https://ic0.app"
  });
  
  console.log(agent);

  const { metadata } = IcrcLedgerCanister.create({
    agent: agent,
    canisterId: 'mxzaz-hqaaa-aaaar-qaada-cai'
  });

  try {
    const data = await metadata();
  } catch (err) {
    console.log(err);
  }

</script>