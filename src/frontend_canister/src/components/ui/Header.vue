<template>
  <header :class="`fixed w-full z-30 md:bg-opacity-90 transition duration-300 ease-in-out ${!top ? 'bg-white backdrop-blur-sm shadow-lg' : ''}`">
    <div class="max-w-6xl mx-auto px-5 sm:px-6">
      <div class="flex items-center justify-between h-16 md:h-20">

        <!-- Site branding -->
        <div class="shrink-0 mr-4">
          <router-link :to="{name: 'Home'}">
            <Logo />
          </router-link>
        </div>

        <div class="px-10">
          <ul class="flex grow justify-end flex-wrap items-center space-x-12">
            <li>
              DAO
            </li>
            <li>
              Бибилотека
            </li>
          </ul>
        </div>

        <!-- Desktop navigation -->
        <nav class="hidden md:flex md:grow">
          <!-- Desktop sign in links -->
          <ul class="flex grow justify-end flex-wrap items-center" v-if="!authStore.isAuthenticated">
            <!-- <li>
              <router-link to="/signin" class="font-medium text-gray-600 hover:text-gray-900 px-5 py-3 flex items-center transition duration-150 ease-in-out">Sign in</router-link>
            </li> -->
            <li>
              <LoginButton />
            </li>
          </ul>
          <ul class="flex grow justify-end flex-wrap items-center" v-else>
            <li>
              <UserMenu />
            </li>
          </ul>
        </nav>

        <MobileMenu />
      </div>
    </div>
  </header>
</template>

<script setup>
  import { onMounted, onUnmounted, ref } from 'vue';
  import Logo from './Logo.vue';
  import MobileMenu from './MobileMenu.vue';
  import UserMenu from './UserMenu.vue';
  import LoginButton from './buttons/LoginButton.vue';
  import { useAuthStore } from "../../store/auth";

  const authStore = useAuthStore();
  const top = ref(true);

  const scrollHandler = () => {
    window.scrollY > 10 ? top.value = false : top.value = true;
  };

  onMounted(() => {
    scrollHandler();
    window.addEventListener('scroll', scrollHandler);
  });

  onUnmounted(() => {
    window.removeEventListener('scroll', scrollHandler);
  });
</script>