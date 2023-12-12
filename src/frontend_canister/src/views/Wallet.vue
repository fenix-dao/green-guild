<template>
  <div>
    <div class="mb-10">
      <div class="flex gap-x-4 items-center">
        <div>
          <img src="avatars/default_avatar.png"  class=" w-16"/>
        </div>
        <div>
          <div class="flex flex-wrap">
            <h2 class="w-full text-base font-semibold leading-none">Account ID:</h2>
            <span class="text-base truncate">{{ authStore.accountId }}</span> <ArrowTopRightOnSquareIcon class="w-5 ml-1 inline-block cursor-pointer" @click="openCopyAddressModal(authStore.accountId)" />
          </div>
          <div class="flex flex-wrap mt-2">
            <h2 class="text-base w-full font-semibold leading-none">Principal ID:</h2>
            <span class="text-base truncate">{{ authStore.identity.getPrincipal() }}</span> <ArrowTopRightOnSquareIcon class="w-5 ml-1 inline-block cursor-pointer" @click="openCopyAddressModal(authStore.identity.getPrincipal().toText())" />
          </div>
        </div>
      </div>
    </div>
    
    <div class="relative overflow-x-auto">
        <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3 w-80">
                        Token
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Balance
                    </th>
                    <th scope="col" class="px-6 py-3 text-right">
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
                        <div class="flex gap-x-2 justify-end">
                          <!-- <button class="btn-sm text-sm p-2 hover:text-black">Receive</button> -->
                          <button class="btn-sm text-sm p-2 hover:text-black">Send</button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <DefaultModal title="test" :isOpen="copyAddressModalData.isOpen" @update:isOpen="copyAddressModalData.isOpen = $event">
      <h3 class=" text-2xl mb-4 font-semibold">Address</h3>
      <div class="flex flex-wrap gap-y-4">
        <div class="flex justify-center w-full">
          <qrcode-vue :value="copyAddressModalData.address" :size="150" level="H" />
        </div>
        <div class="w-full text-center">
          <span class="text-base">{{ copyAddressModalData.address }}</span>
        </div>
        <button class="btn-sm w-full btn-gray" @click="copyToClipboard(copyAddressModalData.address)">Copy</button>
      </div>
    </DefaultModal>
    
    <DefaultModal title="test" :isOpen="copyAddressModalData.isOpen" @update:isOpen="copyAddressModalData.isOpen = $event">
      <h3 class=" text-2xl mb-4 font-semibold">Address</h3>
      <div class="flex flex-wrap gap-y-4">
        <div class="flex justify-center w-full">
          <qrcode-vue :value="copyAddressModalData.address" :size="150" level="H" />
        </div>
        <div class="w-full text-center">
          <span class="text-base">{{ copyAddressModalData.address }}</span>
        </div>
        <button class="btn-sm w-full btn-gray" @click="copyToClipboard(copyAddressModalData.address)">Copy</button>
      </div>
    </DefaultModal>
  </div>

</template>

<script setup>
  import { ArrowTopRightOnSquareIcon } from '@heroicons/vue/20/solid';
  import { useAuthStore } from '../store/auth';
  import QrcodeVue from 'qrcode.vue'
  import DefaultModal from '../components/ui/DefaultModal.vue';
  import { ref, reactive, computed } from 'vue';
  import { copyToClipboard, convertTokenValueToNumber, convertArrayToObject } from '../helpers';
  import { IcrcLedgerCanister } from "@dfinity/ledger-icrc";
  import { createAgent } from "@dfinity/utils";

  const isPrincipalModalOpen = ref(false);
  const authStore = useAuthStore();

  const copyAddressModalData = reactive({
    isOpen: false,
    address: null,
  });

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

  function openCopyAddressModal(address) {
    copyAddressModalData.address = address;
    copyAddressModalData.isOpen = true;
  }

  async function getTokenBalance(ledgerCanisterId) {
    const { balance, metadata } = IcrcLedgerCanister.create({
      agent: agent,
      canisterId: ledgerCanisterId
    });

    const metadataResponse = await metadata({});
    const metadataObj = convertArrayToObject(metadataResponse);

    const rawBalance = await balance({
      owner: authStore.identity.getPrincipal(),
      certified: true
    });
    return convertTokenValueToNumber(rawBalance, Number(metadataObj["icrc1:decimals"]));
  }

  async function updateAllBalances() {
    Object.keys(tokens).forEach(async key => {
      let balance = await getTokenBalance(tokens[key].canisterId);
      tokens[key].balance = balance;
    });
  }
</script>