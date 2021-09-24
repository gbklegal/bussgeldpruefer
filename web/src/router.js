import { createWebHistory, createRouter } from "vue-router";
import Home from './views/Home.vue'
import NotFound from './views/NotFound.vue'
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
import CatalogSingle from './views/CatalogSingle.vue'
import Blog from './views/Blog.vue'
import BlogSingle from './views/BlogSingle.vue'
import BlogAuthor from './views/BlogAuthor.vue'
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
import ProfileMailCourt from './views/ProfileMailCourt.vue'
import ProfileMailOutsideCourt from './views/ProfileMailOutsideCourt.vue'
import ProfileMailElse from './views/ProfileMailElse.vue'
import ProfileMailSent from './views/ProfileMailSent.vue'
import ProfileMailMarked from './views/ProfileMailMarked.vue'
import ProfileMailNewMessage from './views/ProfileMailNewMessage.vue'
import ContactThankYou from './views/ContactThankYou.vue'

import DEV from './views/DEV.vue'


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
        path: '/danke-fuer-deine-nachricht',
        name: 'contact-thank-you',
        component: ContactThankYou
    },
    {
        path: '/impressum',
        name: 'legal-contact',
        component: LegalContact
    },
    {
        path: '/datenschutz',
        name: 'privacy',
        component: Privacy
    },
    {
        path: '/rechtliche-hinweise',
        name: 'terms-of-service',
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
    // {
    //     path: '/profil',
    //     name: 'profile',
    //     component: Profile,
    //     children: [
    //         {
    //             path: '/profil/posteingang',
    //             name: 'profile-mail',
    //             component: ProfileMail,
    //             children: [
    //                 {
    //                     path: '/profil/posteingang/gerichtliche-angelegenheiten',
    //                     name: 'profile-mail-court',
    //                     component: ProfileMailCourt,
    //                 },
    //                 {
    //                     path: '/profil/posteingang/aussergerichtliche-angelegenheiten',
    //                     name: 'profile-mail-outside-court',
    //                     component: ProfileMailOutsideCourt,
    //                 },
    //                 {
    //                     path: '/profil/posteingang/sonstiges',
    //                     name: 'profile-mail-else',
    //                     component: ProfileMailElse,
    //                 },
    //                 {
    //                     path: '/profil/posteingang/gesendet',
    //                     name: 'profile-mail-sent',
    //                     component: ProfileMailSent,
    //                 },
    //                 {
    //                     path: '/profil/posteingang/markiert',
    //                     name: 'profile-mail-marked',
    //                     component: ProfileMailMarked,
    //                 },
    //                 {
    //                     path: '/profil/posteingang/neue-nachricht',
    //                     name: 'profile-mail-new-message',
    //                     component: ProfileMailNewMessage,
    //                 },
    //             ]
    //         },
    //         {
    //             path: '/profil/status',
    //             name: 'profile-status',
    //             component: ProfileStatus
    //         },
    //         {
    //             path: '/profil/dokumente',
    //             name: 'profile-documents',
    //             component: ProfileDocuments
    //         }
    //     ]
    // },
    {
        path: '/ratgeber',
        name: 'blog',
        component: Blog
    },
    {
        path: '/ratgeber/:postSlug',
        name: 'blog-single',
        component: BlogSingle
    },
    {
        path: '/ratgeber/autor/:authorSlug',
        name: 'blog-author',
        component: BlogAuthor
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
                path: '/bussgeldkatalog/:docSlug',
                name: 'catalog-single',
                component: CatalogSingle
            },
            {
                path: '/bussgeldkatalog/alkohol',
                name: 'catalog-alcohol',
                component: CatalogSingleAlcohol
            },
            {
                path: '/bussgeldkatalog/else',
                name: 'catalog-else',
                component: CatalogSingleElse
            }
        ]
    },
    {
        path: '/topics-single',
        name: 'topics-single',
        component: TopicsSingle
    },
    {
        path: '/order-thank-you',
        name: 'order-thank-you',
        component: OrderTankYou
    },
    {
        path: '/profile-signup',
        name: 'profile-signup',
        component: ProfileSignUp
    },
    {
        path: '/dev',
        name: 'dev',
        component: DEV
    },
    {
        path: '/:pathMatch(.*)*',
        name: 'not-found',
        component: NotFound
    },
]

const router = createRouter({ history, routes })
export default router