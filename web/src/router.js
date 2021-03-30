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
import CatalogSingleAlcohol from './views/CatalogSingleAlcohol.vue'
import CatalogSingleElse from './views/CatalogSingleElse.vue'
import TopicsSingle from './views/TopicsSingle.vue'
import OrderTankYou from './views/OrderThankYou.vue'
import ProfileSignUp from './views/ProfileSignUp.vue'
import ProfileMail from './views/ProfileMail.vue'
import ProfileStatus from './views/ProfileStatus.vue'
import ProfileDocuments from './views/ProfileDocuments.vue'

const history = createWebHistory()

const routes = [
    {
        path: '/',
        name: 'home',
        component: Home
    },
    {
        path: '/bussgeldbescheid-pruefen',
        name: 'order',
        component: Order
    },
    {
        path: '/partnerprogramm',
        name: 'partners',
        component: Partners
    },
    {
        path: '/kontakt',
        name: 'contact',
        component: Contact
    },
    {
        path: '/impressum',
        name: 'legalcontact',
        component: LegalContact
    },
    {
        path: '/datenschutz',
        name: 'privacy',
        component: Privacy
    },
    {
        path: '/rechtliche-hinweise',
        name: 'termsofservice',
        component: TermsOfService
    },
    {
        path: '/login',
        name: 'login',
        component: Login
    },
    {
        path: '/wie-funktionierts',
        name: 'howto',
        component: HowTo
    },
    {
        path: '/profil',
        name: 'profile',
        component: Profile,
        children: [
            {
                path: '/profil/posteingang',
                name: 'posteingang',
                component: ProfileMail
            },
            {
                path: '/profil/status',
                name: 'status',
                component: ProfileStatus
            },
            {
                path: '/profil/dokumente',
                name: 'documents',
                component: ProfileDocuments
            }
        ]
    },
    {
        path: '/ratgeber',
        name: 'blog',
        component: Blog
    },
    {
        path: '/faq',
        name: 'faq',
        component: FAQ
    },
    {
        path: '/relevante-themen',
        name: 'topics',
        component: Topics
    },
    {
        path: '/registrieren',
        name: 'signup',
        component: SignUp
    },
    {
        path: '/bussgeldkatalog',
        name: 'catalog',
        component: Catalog,
        children: [
            {
                path: '/bussgeldkatalog/alkohol',
                name: 'alkohol',
                component: CatalogSingleAlcohol
            },
            {
                path: '/bussgeldkatalog/else',
                name: 'else',
                component: CatalogSingleElse
            }
        ]
    },
    {
        path: '/topics-single',
        name: 'topicssingle',
        component: TopicsSingle
    },
    {
        path: '/order-thank-you',
        name: 'orderthankyou',
        component: OrderTankYou
    },
    {
        path: '/profile-signup',
        name: 'profilesignup',
        component: ProfileSignUp
    }
]

const router = createRouter({ history, routes })
export default router