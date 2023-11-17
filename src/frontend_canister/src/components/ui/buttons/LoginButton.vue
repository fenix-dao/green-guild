<template>
  <div>
    <button type="button" id="loginButton" class="btn-sm text-gray-200 bg-gray-900 hover:bg-gray-800 ml-3" @click="authStore.login()">
      <span>Вход</span>
      <svg class="w-3 h-3 fill-current text-gray-400 shrink-0 ml-2 -mr-1" viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg">
        <path d="M11.707 5.293L7 .586 5.586 2l3 3H0v2h8.586l-3 3L7 11.414l4.707-4.707a1 1 0 000-1.414z" fill-rule="nonzero" />
      </svg>
    </button>
  </div>
</template>
<script setup>
  import { useAuthStore } from "../../../store/auth";

  const authStore = useAuthStore();
</script>