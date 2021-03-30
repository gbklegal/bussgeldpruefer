<template>
    <header id="header" class="bg-white">
        <a class="sr-only" href="#main">Skip to content</a>
        <nav id="nav" class="py-2 px-3 border-b-2 border-primary shadow" aria-label="primary navigation">
                <div class="logo py-1">
                    <router-link class="" to="/">
                        <img class="w-44 h-8" src="../assets/img/logo.svg" alt="BussgeldPrüfer" />
                    </router-link>
                </div>

                <button v-on:click="menuOpen = !menuOpen" class="w-7 xl:hidden xl:invisible focus:ring rounded focus:border-secondary focus:ring-secondary focus:ring-opacity-50">
                    <!-- Icons from Heroicon -->
                    <svg v-if="!menuOpen" role="img" aria-labelledby="openMenu" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <title id="openMenu">Open Menu</title>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                    </svg>
                    <svg v-if="menuOpen" role="img" aria-labelledby="closeMenu" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <title id="closeMenu">Close Menu</title>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
                <div class="navigation-buttons">
                    <router-link class="btn-primary" to="/bussgeldbescheid-pruefen">Bussgeldbescheid Prüfung</router-link>
                    <router-link class="btn-secondary" to="/login">Login</router-link>
                </div>
            <ul class="header-navigation" :class="{ block: menuOpen }">
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link to="/wie-funktionierts">Wie funktioniert's</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link to="/profil/posteingang">Mein Profil</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link to="/kontakt">Kontakt</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link to="/bussgeldkatalog">Bußgeldkatalog</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link to="/ratgeber">Bußgeldratgeber</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link to="/faq">FAQ</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link to="/relevante-themen">relevante Bußgeldthemen</router-link>
                </li>
            </ul>
        </nav>
    </header>
</template>
<script>
export default { 
    name: 'Header',
    data: () => {
        return {
            menuOpen: false,
        }
    }
}
</script>
<style scoped>
    nav {
        display: grid;
        grid-row-gap: 1em;
        grid-template-areas:
            'logo toggle'
            'btns btns'
            'ul ul';
    }
    
    img {
        grid-area: logo;
    }

    button {
        grid-area: toggle;
        justify-self: end;
    }

    ul {
        grid-area: ul;
        margin-top: 2em;
    }

    .navigation-buttons {
        grid-area: btns;
        display: flex;
        justify-content: space-between;
    }

    .header-navigation {
        display: none; 
    }

    .block {
        display: block;
    }

   @media (min-width: 768px) {
        nav {
            grid-template-areas: 
                'logo btns toggle'
                'ul ul ul';
            align-items: center;
            grid-template-columns: 1fr auto;
            grid-row-gap: 0;
        }

        .navigation-buttons a {
            margin-right: 0.5em;
        }
    }

    @media (min-width: 1300px) {
        nav {
            grid-template-areas:
                'logo btns'
                'ul ul';
        }

        .header-navigation {
            display: flex;
            justify-self: end;
        }

        .header-navigation li {
            margin: 0.5em;
        }

        .header-navigation a {
            padding: 0.5em;
        }

        button {
            display: none;
            visibility: hidden;
        }

        ul {
            margin-top: 0;
        }

    }

</style>