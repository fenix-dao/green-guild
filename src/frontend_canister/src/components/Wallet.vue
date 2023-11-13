<template>
  <div>
    Wallet<br>
    Balances:
    <ul>
      <li>
        Internet Computer Bulgaria {{ token.metadata['icrc1:symbol'] }}<br>
        {{ token.balance.numberValue }} (balance)<br>
        {{ token.totalTokensSupply }} (total supply)<br>
        <div>
          <input type="text" class="border" placeholder="Enter principal ID" v-model="transferData.principalId">
          <input type="text" class="border" placeholder="Enter amount to send" v-model="transferData.amount">
          <button class="border" @click="transferTokens()">Transfer</button>
        </div>
        
      </li>
    </ul>
  </div>
</template>
<script setup>
  import { IcrcLedgerCanister } from "@dfinity/ledger-icrc";
  import { createAgent } from "@dfinity/utils";
  import { useAuthStore } from "../store/auth";
  import { convertArrayToObject, convertTokenValueToNumber } from "../helpers"
  import { computed, ref, reactive } from "vue";
  import { Principal } from "@dfinity/principal";

  const authStore = useAuthStore();
  
  const agent = await createAgent({
    identity: authStore.identity
  });

  await agent.fetchRootKey();

  const { metadata, balance, transfer, totalTokensSupply } = IcrcLedgerCanister.create({
    agent: agent,
    canisterId: 'mxzaz-hqaaa-aaaar-qaada-cai'
  });

  const metadataValue = ref(null);
  const userBalance = ref(null);
  const totalTokensSupplyValue = ref(null);

  const transferData = reactive({});

  async function fetchData() {
      const rawMetadata = await metadata({certified: false});
      metadataValue.value = convertArrayToObject(rawMetadata);

      const rawBalance = await balance({
        owner: authStore.identity.getPrincipal(),
        certified: false
      });

      userBalance.value = {
        bigIntValue: rawBalance,
        numberValue: convertTokenValueToNumber(rawBalance)
      }

      const totalSupply = await totalTokensSupply({certified: false});

      totalTokensSupplyValue.value = convertTokenValueToNumber(totalSupply);
  }

  await fetchData();

  const token = computed(() => ({
    metadata: metadataValue.value,
    balance: userBalance.value,
    totalTokensSupply: totalTokensSupplyValue.value
  }));

  async function transferTokens() {
    if(transferData) {
      console.log(transferData.amount);
      let data = await transfer({
        to: {
          owner: Principal.fromText(transferData.principalId),
          subaccount: []
        },
        amount: BigInt(transferData.amount * (10 ** 8))
      })

      resetTransferData();
      fetchData();
    }
  }

  // Function to reset transferData
  function resetTransferData() {
    transferData.principalId = '';
    transferData.amount = '';
  }
</script>