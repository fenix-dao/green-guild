<template lang="">
  <div v-if="isReady" class="flex flex-col min-h-screen overflow-hidden supports-[overflow:clip]:overflow-clip">
    <Header />

    <section class="relative">
      <div class="relative max-w-6xl mx-auto px-4 sm:px-6">
        <div class="pt-24 pb-12 md:pt-32 md:pb-20">
          <router-view/>
          <!-- <div v-if="isAuthenticated">
            {{ authStore.principalId }}<br>
            <Suspense>
              <Wallet />
            </Suspense>
          </div> -->
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
  import { storeToRefs } from "pinia";
  import { useAuthStore } from "./store/auth";
  import Wallet from "./components/Wallet.vue";
  import Header from "./components/ui/Header.vue";
  import { ref } from "vue";

  const authStore = useAuthStore();
  const { isReady, isAuthenticated } = storeToRefs(authStore);
  const response = ref("");

  if (isReady.value === false) {
    authStore.init();
  }
</script>