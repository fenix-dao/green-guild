<template>
  <div>
    <button type="button" id="logoutButton" @click="async () => await authStore.logout()">Logout</button>
  </div>
</template>
<script setup>
  import { useAuthStore } from "../store/auth";

  const authStore = useAuthStore();
</script>