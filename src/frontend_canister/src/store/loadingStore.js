// store/loadingStore.js
import { defineStore } from 'pinia';

export const useLoadingStore = defineStore('loading', {
  state: () => ({
    isLoading: false
  }),
  actions: {
    showLoading() {
      this.isLoading = true;
      document.body.classList.add('no-click');
    },
    hideLoading() {
      this.isLoading = false;
      document.body.classList.remove('no-click');
    }
  }
});
