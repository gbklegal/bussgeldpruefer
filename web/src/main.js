import { createApp } from 'vue';
import App from './App.vue';
import './index.css';
import router from "./router";

router.beforeEach((_to, _from, next) => {
    window.scrollTo(0, 0);
    next();
});

createApp(App).use(router).mount('#app');