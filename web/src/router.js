import { createWebHistory, createRouter } from "vue-router";
import Home from './views/Home.vue'
import About from './views/About.vue'
import Order from './views/Order.vue'

const history = createWebHistory()

const routes = [
    { path: '/', component: Home },
    { path: '/about', component: About },
    { path: '/bussgeldbescheid-pruefen', component: Order },
]

const router = createRouter({ history, routes })
export default router