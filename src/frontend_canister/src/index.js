import { createApp, version } from 'vue';
import App from './App.vue';
import router from './router';
import { createPinia } from 'pinia';

import './tailwind.css';

const app = createApp(App);

console.log(version);

app.use(createPinia());
app.use(router);
app.mount("#app");