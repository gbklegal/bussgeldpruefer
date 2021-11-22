<template>
    <footer class="px-3 border-t-2 border-primary bg-white pt-2">
        <p>&copy; BussgeldPrüfer {{ currentYear }}</p>
        <nav aria-label="secondary navigation">
            <ul>
                <li>
                   <router-link :to="{ name: 'partners' }">Partnerprogramm</router-link>
                </li>
                <li>
                    <router-link :to="{ name: 'contact' }">Kontakt</router-link>
                </li>
                <li>
                    <router-link :to="{ name: 'legal-contact' }">Impressum</router-link>
                </li>
                <li>
                    <router-link :to="{ name: 'privacy' }">Datenschutz</router-link>
                </li>
                <li>
                    <router-link :to="{ name: 'terms-of-service' }">Rechtliche Hinweise</router-link>
                </li>
            </ul>
        </nav>
        <div class="footer-contact">
            <div>
                <span class="mr-2">E-Mail:</span>
                <a href="mailto:dialog(at)bussgeldpruefer.com" @click.prevent="mailTo">dialog(at)bussgeldpruefer.com</a>
            </div>
            <div>
                <span class="mr-2">Telefon:</span>
                <a href="tel:091112345678">0911 / 12345678</a>
            </div>
        </div>
        <div class="app">
            <a href="https://bussgeldpruefer.app/android" target="_blank" rel="noopener noreferrer">
                <img class="h-12" src="../assets/img/google-play-badge.png" alt="Jetzt bei Google Play downloaden.">
            </a>
            <a href="https://bussgeldpruefer.app/ios" target="_blank" rel="noopener noreferrer">
                <img class="h-12" src="../assets/img/app-store-badge.png" alt="Laden im App Store.">
            </a>
        </div>
    </footer>
</template>
<script>
import global from '../global';

export default {
    name: 'Footer',
    data: function() {
        return {
            currentYear: global.date.currentYear,
        }
    },

    methods: {
        mailTo() {
            global.linkTo_UnCryptMailto('nbjmup;ejbmphAcvtthfmeqsvfgfs/dpn');
        }
    }
}
</script>
<style scoped>
    footer {
        display: grid;
        grid-template-areas:
            'logo'
            'nav'
            'contact'
            'app';
        justify-items: end;
        grid-row-gap: 2em;
    }

    p {
        grid-area: logo;
        justify-self: start;
        align-self: center;
    }

    nav {
        grid-area: nav;
    }

    nav li {
        display: inline-block;
        padding: 0.5em;
    }

    .footer-contact {
        grid-area: contact;
    }

    .app {
        grid-area: app;
    }

    .app img {
        display: inline;
    }

    @media (min-width: 930px) {
        footer {
            grid-template-areas:
                'logo nav'
                '. contact'
                '. app';
        }
    }
</style>