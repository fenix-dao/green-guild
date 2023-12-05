<template>
  <TransitionRoot appear :show="props.isOpen" as="template">
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
              class="w-auto max-w-3xl p-8 transform overflow-hidden rounded-2xl bg-white pt-7 text-left align-middle shadow-xl transition-all"
            > 
              <div class="">
                <slot></slot>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup>
  import {
    TransitionRoot,
    TransitionChild,
    Dialog,
    DialogPanel,
    DialogTitle,
  } from '@headlessui/vue'
  
  import { ref } from 'vue';

  const emit = defineEmits(['update:isOpen'])

  const props = defineProps({
    title: String,
    isOpen: Boolean
  })

  function openModal() {
    emit('update:isOpen', true);
  }

  function closeModal() {
    emit('update:isOpen', false);
  }
</script>