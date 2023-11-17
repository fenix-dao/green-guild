<template>
  <div class="flex md:hidden">
    <!-- Hamburger button -->
    <button
      ref="trigger"
      :class="`hamburger ${mobileNavOpen ? 'active' : ''}`"
      aria-controls="mobile-nav"
      :aria-expanded="mobileNavOpen"
      @click="toggleMobileNav"
    >
      <span class="sr-only">Menu</span>
      <svg class="w-6 h-6 fill-current text-gray-900" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
        <rect y="4" width="24" height="2" />
        <rect y="11" width="24" height="2" />
        <rect y="18" width="24" height="2" />
      </svg>
    </button>

    <!-- Mobile navigation -->
    <TransitionRoot
      appear
      :show="mobileNavOpen"
      as="template"
      enter="transform transition duration-[400ms]"
      enter-from="opacity-0 translate-y-full"  
      enter-to="opacity-100 translate-y-0"
      leave="transform transition duration-[400ms]"
      leave-from="opacity-100 translate-y-0"
      leave-to="opacity-0 translate-y-full"
    >
      <div ref="mobileNav" class="absolute top-full h-screen pb-16 z-20 left-0 w-full overflow-scroll bg-white">
        <ul class="px-5 py-2">
          <li>
            <LoginButton />
          </li>
        </ul>
      </div>
    </TransitionRoot>
  </div>
</template>

<script setup>
  import { ref, onMounted, onUnmounted } from 'vue';
  import { TransitionRoot } from '@headlessui/vue';
  import LoginButton from './buttons/LoginButton.vue'

  const mobileNavOpen = ref(false);
  const trigger = ref(null);
  const mobileNav = ref(null);

  const toggleMobileNav = () => {
    mobileNavOpen.value = !mobileNavOpen.value;
  };

  const closeMobileNav = ({ target }) => {
    if (!mobileNav.value || !trigger.value) return;
    if (mobileNavOpen.value && !mobileNav.value.contains(target) && !trigger.value.contains(target)) {
      mobileNavOpen.value = false;
    }
  };

  const onKeydown = ({ keyCode }) => {
    if (mobileNavOpen.value && keyCode === 27) mobileNavOpen.value = false;
  };

  onMounted(() => {
    document.addEventListener('click', closeMobileNav);
    document.addEventListener('keydown', onKeydown);
  });

  onUnmounted(() => {
    document.removeEventListener('click', closeMobileNav);
    document.removeEventListener('keydown', onKeydown);
  });
</script>