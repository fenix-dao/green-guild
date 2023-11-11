<template lang="">
  <div v-if="isReady">
    <div v-if="isAuthenticated">
      {{ authStore.principalId }}<br>
      <Logout />
    </div>
    <div v-else>
      <Login />
    </div>
  </div>
  <router-view/>
</template>

<script setup>
  import { storeToRefs } from "pinia";
  import { useAuthStore } from "./store/auth";
  import Login from "./components/Login.vue";
  import Logout from "./components/Logout.vue";
  import { ref } from "vue";

  const authStore = useAuthStore();
  const { isReady, isAuthenticated } = storeToRefs(authStore);
  const response = ref("");

  if (isReady.value === false) {
    authStore.init();
  }

  function whoamiCall() {
    authStore.whoamiActor?.whoami().then((res) => {
      response.value = res;
    });
  }
</script>