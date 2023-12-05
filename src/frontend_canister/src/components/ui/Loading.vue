<template>
<!-- component -->
<div v-if="loadingStore.isLoading" class="fixed flex items-center justify-center w-full h-full z-[9999] bg-black/50">
	<div class="flex justify-center items-center space-x-1 text-sm text-white">
		 
				<svg fill='none' class="w-10 h-10 animate-spin" viewBox="0 0 32 32" xmlns='http://www.w3.org/2000/svg'>
					<path clip-rule='evenodd'
						d='M15.165 8.53a.5.5 0 01-.404.58A7 7 0 1023 16a.5.5 0 011 0 8 8 0 11-9.416-7.874.5.5 0 01.58.404z'
						fill='currentColor' fill-rule='evenodd' />
				</svg>

		 
		<div class="text-2xl">Loading ...</div>
	</div>
</div>
</template>

<script setup>
    import { useLoadingStore } from '../../store/loadingStore';

    const loadingStore = useLoadingStore();
</script>

<style>
</style>