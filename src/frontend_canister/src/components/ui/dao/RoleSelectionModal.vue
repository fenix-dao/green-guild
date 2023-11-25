<template>
  <div class="fixed inset-0 flex items-center justify-center">
    <button
      type="button"
      @click="openModal"
      class="rounded-md bg-black/20 px-4 py-2 text-sm font-medium text-white hover:bg-black/30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white/75"
    >
      Open dialog
    </button>
  </div>
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
        <div class="fixed inset-0 bg-black/25" />
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
              class="w-full max-w-3xl pb-8 transform overflow-hidden rounded-2xl bg-white p-0 text-left align-middle shadow-xl transition-all"
            >
              <DialogTitle
                as="h3"
                class="text-4xl text-center pb-4 font-medium leading-6 text-gray-900"
              >
              <img src="covers/become-a-member-cover.png" />
              </DialogTitle>
              <div>
              </div>

              <div>
                <span class="block text-center">Choose your role:</span>
                <div class="flex">
                  <button
                    type="button"
                    class="inline-flex justify-center rounded-md border border-transparent bg-blue-200 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-600 hover:text-white focus:outline-none focus-visible:ring-2"
                    @click="closeModal"
                  >
                    Volunteer
                  </button><button
                    type="button"
                    class="inline-flex justify-center rounded-md border border-transparent bg-blue-200 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-600 hover:text-white focus:outline-none focus-visible:ring-2"
                    @click="closeModal"
                  >
                    Contributor
                  </button>
                </div>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup>
  import { ref } from 'vue'
  import {
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogPanel,
    DialogTitle,
  } from '@headlessui/vue'

  const isOpen = ref(false)

  function closeModal() {
    isOpen.value = false
  }
  function openModal() {
    isOpen.value = true
  }
</script>