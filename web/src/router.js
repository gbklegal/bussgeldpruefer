import { createWebHistory, createRouter } from "vue-router";
import Home from './views/Home.vue'
import About from './views/About.vue'
import Order from './views/Order.vue'
import Partners from './views/Partners.vue'
import Contact from './views/Contact.vue'
import LegalContact from './views/LegalContact.vue'
import Privacy from './views/Privacy.vue'
import TermsOfService from './views/TermsOfService.vue'

const history = createWebHistory()

const routes = [
    { path: '/', component: Home },
    { path: '/about', component: About },
    { path: '/bussgeldbescheid-pruefen', component: Order },
    { path: '/partnerprogramm', component: Partners },
    { path: '/kontakt', component: Contact },
    { path: '/impressum', component: LegalContact },
    { path: '/datenschutz', component: Privacy },
    { path: '/rechtliche-hinweise', component: TermsOfService },
]

const router = createRouter({ history, routes })
export default router