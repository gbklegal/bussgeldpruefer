<template>
    <header id="header" class="bg-white">
        <a class="sr-only" href="#main">Skip to content</a>
        <nav id="nav" class="py-2 px-3 border-b-2 border-primary shadow" aria-label="primary navigation">
                <div class="logo py-1">
                    <router-link class="" :to="{name: 'home'}">
                        <img class="w-44" src="../assets/img/logo.png" alt="BussgeldPrüfer" />
                    </router-link>
                </div>

                <button v-on:click="menuOpen = !menuOpen" class="w-7 xl:hidden xl:invisible focus:ring rounded focus:border-secondary focus:ring-secondary focus:ring-opacity-50">
                    <!-- Icons from Heroicon -->
                    <svg v-if="!menuOpen" role="img" aria-labelledby="openMenu" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <title id="openMenu">Menü öffnen</title>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                    </svg>
                    <svg v-if="menuOpen" role="img" aria-labelledby="closeMenu" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <title id="closeMenu">Menü schließen</title>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
                <div class="navigation-buttons">
                    <router-link class="btn-primary" :to="{ name: 'order'}">Bußgeldbescheid Prüfung</router-link>
                    <!-- <router-link class="btn-secondary" :to="{ name: 'login' }">Login</router-link> -->
                </div>
            <ul class="header-navigation" :class="{ block: menuOpen }">
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link :to="{ name: 'howto' }">Wie funktioniert's</router-link>
                </li>
                <!-- <li v-on:click="menuOpen = !menuOpen">
                    <router-link :to="{ name: 'profile-mail'}">Mein Profil</router-link>
                </li> -->
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link :to="{ name: 'contact' }">Kontakt</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link :to="{ name: 'catalog' }">Bußgeldkatalog</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link :to="{ name: 'blog' }">Bußgeldratgeber</router-link>
                </li>
                <li v-on:click="menuOpen = !menuOpen">
                    <router-link :to="{ name: 'faq' }">FAQ</router-link>
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