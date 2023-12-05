<template>
  <div class="mb-10">
    <div class="flex gap-x-4 items-center">
      <div>
        <img src="avatars/default_avatar.png"  class=" w-16"/>
      </div>
      <div>
        <h1 class="text-lg font-semibold leading-none">Principal ID</h1>
        <span class="text-base truncate">{{ authStore.identity.getPrincipal() }}</span> <ArrowTopRightOnSquareIcon class="w-5 inline-block cursor-pointer" @click="showAddressModal" />
      </div>
    </div>
  </div>
  
  <div class="relative overflow-x-auto">
      <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
          <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
              <tr>
                  <th scope="col" class="px-6 py-3">
                      Token
                  </th>
                  <th scope="col" class="px-6 py-3">
                      Balance
                  </th>
                  <th scope="col" class="px-6 py-3">
                      Actions
                  </th>
              </tr>
          </thead>
          <tbody>
              <tr class="bg-white dark:bg-gray-800" v-for="token in tokens">
                  <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                      <div class="flex gap-x-3">
                        <div>
                          <img :src="'tokens/' + token.logo" class="w-10">
                        </div>
                        <div>
                          {{ token.symbol }}<br>
                          <small class=" opacity-50 text-sm">{{ token.name }}</small>
                        </div>
                      </div>
                  </th>
                  <td class="px-6 py-4">
                      {{ token.balance }}
                  </td>
                  <td class="px-6 py-4">
                      <div class="flex gap-x-2">
                        <!-- <button class="btn-sm text-sm p-2 hover:text-black">Receive</button> -->
                        <button class="btn-sm text-sm p-2 hover:text-black">Send</button>
                      </div>
                  </td>
              </tr>
          </tbody>
      </table>
  </div>
  
  <DefaultModal title="test" :isOpen="isPrincipalModalOpen" @update:isOpen="isPrincipalModalOpen = $event">
    <h3 class=" text-2xl mb-4 font-semibold">Address</h3>
    <div class="flex flex-wrap gap-y-4">
      <div class="flex justify-center w-full">
        <qrcode-vue :value="authStore.identity.getPrincipal()" :size="150" level="H" />
      </div>
      <div class="w-full text-center">
        <span class="text-base">{{ authStore.identity.getPrincipal() }}</span>
      </div>
      <button class="btn-sm w-full btn-gray" @click="copyToClipboard(authStore.identity.getPrincipal())">Copy</button>
    </div>
  </DefaultModal>

</template>

<script setup>
  import { ArrowTopRightOnSquareIcon } from '@heroicons/vue/20/solid';
  import { useAuthStore } from '../store/auth';
  import QrcodeVue from 'qrcode.vue'
  import DefaultModal from '../components/ui/DefaultModal.vue';
  import { ref, reactive } from 'vue';
  import { copyToClipboard, convertTokenValueToNumber } from '../helpers';
  import { IcrcLedgerCanister } from "@dfinity/ledger-icrc";
  import { createAgent } from "@dfinity/utils";

  const isPrincipalModalOpen = ref(false);
  const authStore = useAuthStore();

  const tokens = reactive({
    "icp": {
      name: "Internet Computer",
      symbol: "ICP",
      canisterId: "ryjl3-tyaaa-aaaaa-aaaba-cai",
      logo: "icp-logo.png",
      balance: '-'
    },
    "ckbtc": {
      name: "Chain-key Bitcoin",
      symbol: "ckBTC",
      canisterId: "mxzaz-hqaaa-aaaar-qaada-cai",
      logo: "ckBTC.png",
      balance: '-'
    }
  });

  const agent = await createAgent({
    identity: authStore.identity,
  });

  await agent.fetchRootKey();
  await updateAllBalances();

  function showAddressModal() {
    isPrincipalModalOpen.value = true;
  }

  async function getTokenBalance(ledgerCanisterId) {
    const { balance } = IcrcLedgerCanister.create({
      agent: agent,
      canisterId: ledgerCanisterId
    });

    const rawBalance = await balance({
      owner: authStore.identity.getPrincipal(),
      certified: true
    });

    return convertTokenValueToNumber(rawBalance);
  }

  async function updateAllBalances() {
    Object.keys(tokens).forEach(async key => {
      console.log(tokens[key]);
      let balance = await getTokenBalance(tokens[key].canisterId);
      tokens[key].balance = balance;
    });
  }
</script>