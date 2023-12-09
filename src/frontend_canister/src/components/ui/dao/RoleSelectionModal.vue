<template>
  <TransitionRoot appear :show="isOpen" as="template">
    <Dialog as="div" @close="closeModal" class="relative z-[999]" static>
      <TransitionChild
        as="template"
        enter="duration-300 ease-out"
        enter-from="opacity-0"
        enter-to="opacity-100"
        leave="duration-200 ease-in"
        leave-from="opacity-100"
        leave-to="opacity-0"
      >
        <div class="fixed inset-0 bg-black/50" />
      </TransitionChild>

      <div class="fixed inset-0 overflow-y-auto">
        <div
          class="flex min-h-full items-center justify-center p-4 text-center"
        >
          <TransitionChild
            as="template"
            enter="duration-300 ease-out"
            enter-from="opacity-0 scale-95"
            enter-to="opacity-100 scale-100"
            leave="duration-200 ease-in"
            leave-from="opacity-100 scale-100"
            leave-to="opacity-0 scale-95"
          >
            <DialogPanel
              class="w-full max-w-3xl pb-10 transform overflow-hidden rounded-2xl bg-white p-0 text-left align-middle shadow-xl transition-all"
            >
              <DialogTitle
                as="h3"
                class="text-4xl text-center pb-6 font-medium leading-6 text-gray-900"
              >
                <div v-if="isNewcomer || isContributor">
                  <img src="covers/welcome-cover.png" />
                </div>
                <div v-else>
                  <img src="covers/become-a-member-cover.png" />
                </div>
              </DialogTitle>
              <div>
              </div>

              <div v-if="!isNewcomer && !isContributor">
                <span class="block text-center">Choose your role:</span>
                <div class="flex">
                  <div class="mx-auto mt-2">
                    <button
                      type="button"
                      class="inline-flex mx-2 focus:outline-none justify-center rounded-md border border-transparent bg-blue-200 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-600 hover:text-white"
                      @click="volunteerRequest()"
                      >
                      Volunteer
                    </button>
                    <button
                      type="button"
                      class="inline-flex mx-2 justify-center rounded-md border border-transparent bg-blue-200 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-600 hover:text-white"
                    >
                      Contributor
                    </button>
                  </div>
                </div>
              </div>
              <div v-else-if="isNewcomer" class="w-full text-center">
                <span class="text-2xl block">Your request has been posted!</span>
                <span class="text-base inline-block max-w-[500px] leading-normal">Please wait for the community to review and respond to your request.</span>
              </div>
              <div v-else-if="isContributor" class="text-2xl w-full text-center">Congrats! 🥳</div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup>
  import { backend_canister } from "../../../../../declarations/backend_canister/index.js";
  import { ref } from 'vue';
  import { storeToRefs } from "pinia";
  import { useAuthStore } from "../../../store/auth";
  import { useLoadingStore } from '../../../store/loadingStore';

  import {
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogPanel,
    DialogTitle,
  } from '@headlessui/vue'

  const isOpen = ref(true);
  const isNewcomer = ref(false);
  const isContributor = ref(false);

  const authStore = useAuthStore();
  const loadingStore = useLoadingStore();

  const { isReady, isAuthenticated } = storeToRefs(authStore);

  if(isAuthenticated) {
    // TODO: Move in app storage - the member data... Grab it on login...
    let memberData = await backend_canister.getAuthenticatedMemberData();

    if(memberData.err == 'No member data found for the current user.') {
      let hasNewcomerRequest = await backend_canister.hasNewcomerProposalRequest();

      if(hasNewcomerRequest) {
        isNewcomer.value = true;
      }

      // isOpen.value = true;
    }
  }

  if (isReady.value === false) {
    authStore.init();
  }

  function closeModal() {
    if(isContributor.value || isNewcomer.value) {
      isOpen.value = false
    }
    isOpen.value = false
  }
  function openModal() {
    isOpen.value = true
  }

  async function volunteerRequest() {
    loadingStore.showLoading();

    let newcomperProposalResponse = await backend_canister.createNewcomerProposal('Anonymous');

    console.log(newcomperProposalResponse);
    loadingStore.hideLoading();
    isNewcomer.value = true;
  }
</script>