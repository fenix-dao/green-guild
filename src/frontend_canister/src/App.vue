<template lang="">
  <div v-if="isReady" class="flex flex-col min-h-screen overflow-hidden supports-[overflow:clip]:overflow-clip">
    <Header />

    <section class="relative">
      <div class="relative max-w-6xl mx-auto px-4 sm:px-6">
        <div class="pt-28 pb-12 md:pt-40 md:pb-20">
          <Suspense>
            <router-view/>
          </Suspense>
          <div v-if="isAuthenticated">
            <Suspense>
              <RoleSelectionModal />
            </Suspense>
          </div>
        </div>
      </div>
    </section>
    
    <Loading />
  </div>
</template>

<script setup>
  import { storeToRefs } from "pinia";
  import { useAuthStore } from "./store/auth";
  import Header from "./components/ui/Header.vue";
  import Loading from "./components/ui/Loading.vue";
  import RoleSelectionModal from "./components/ui/dao/RoleSelectionModal.vue";

  const authStore = useAuthStore();
  const { isReady, isAuthenticated } = storeToRefs(authStore);

  if (isReady.value === false) {
    authStore.init();
  }
</script>