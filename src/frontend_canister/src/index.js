import { createApp, version } from 'vue';
import App from './App.vue';
import router from './router';

const app = createApp(App);

console.log(version);

app.use(router)
app.mount("#app");