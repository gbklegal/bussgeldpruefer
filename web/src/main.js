import { createApp } from 'vue';
import App from './App.vue';
import './index.css';
import router from "./router";

router.beforeEach((_to, _from, next) => {
    window.scrollTo({
        top: 0,
        left: 0,
        behavior: 'auto'
    });
    next();
});

createApp(App).use(router).mount('#app');