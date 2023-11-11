<template>
  <div>
    <button type="button" id="loginButton" @click="authStore.login()">Login</button>
  </div>
</template>
<script setup>
  import { useAuthStore } from "../store/auth";

  const authStore = useAuthStore();
</script>