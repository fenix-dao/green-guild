<template>
  Home<br>
  <router-link :to="{name: 'About'}">About</router-link>
</template>

<script setup>
import { ref, onMounted } from 'vue'

// reactive state
const count = ref(0)

// functions that mutate state and trigger updates
function increment() {
  count.value++
}

// lifecycle hooks
onMounted(() => {
})
</script>