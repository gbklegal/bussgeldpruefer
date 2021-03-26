import { createWebHistory, createRouter } from "vue-router";
import Home from './views/Home.vue'
import Order from './views/Order.vue'
import Partners from './views/Partners.vue'
import Contact from './views/Contact.vue'
import LegalContact from './views/LegalContact.vue'
import Privacy from './views/Privacy.vue'
import TermsOfService from './views/TermsOfService.vue'
import Login from './views/Login.vue'
import HowTo from './views/HowTo.vue'
import Profile from './views/Profile.vue'
import Catalog from './views/Catalog.vue'
import Blog from './views/Blog.vue'
import FAQ from './views/FAQ.vue'
import Topics from './views/Topics.vue'
import SignUp from './views/SignUp.vue'

const history = createWebHistory()

const routes = [
    { path: '/', component: Home },
    { path: '/bussgeldbescheid-pruefen', component: Order },
    { path: '/partnerprogramm', component: Partners },
    { path: '/kontakt', component: Contact },
    { path: '/impressum', component: LegalContact },
    { path: '/datenschutz', component: Privacy },
    { path: '/rechtliche-hinweise', component: TermsOfService },
    { path: '/login', component: Login },
    { path: '/wie-funktionierts', component: HowTo },
    { path: '/profil', component: Profile },
    { path: '/bussgeldkatalog', component: Catalog },
    { path: '/ratgeber', component: Blog },
    { path: '/faq', component: FAQ },
    { path: '/relevante-themen', component: Topics },
    { path: '/registrieren', component: SignUp },
]

const router = createRouter({ history, routes })
export default router