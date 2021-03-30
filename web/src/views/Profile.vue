<template>
    <div class="container profile">
        <h1 class="text-secondary">Mein Profil</h1>
        <div>

            <nav aria-label="Navigation im Profil">
                <ul>
                    <li class="mb-5">
                        <router-link to="/profil/posteingang">
                        <img class="w-6 inline bg-secondary rounded-full p-2 h-10 w-10" src="/src/assets/img/mail.svg" alt="EMail Icon.">
                        Online Posteingang
                        </router-link>
                    </li>
                    <li class="mb-5">
                        <router-link to="/profil/status">
                        <img class="w-6 inline bg-secondary rounded-full p-2 h-10 w-10" src="/src/assets/img/refresh.svg" alt="Neu Laden Icon.">                        
                        Überprüfe den aktuellen Status Deines Falls
                        </router-link>
                    </li>
                    <li>
                        <router-link to="/profil/dokumente">
                        <img class="w-6 inline bg-secondary rounded-full p-2 h-10 w-10" src="/src/assets/img/cloud-upload.svg" alt="EMail Icon.">
                        Dokumenten Übersicht
                        </router-link>
                    </li>
                </ul>
            </nav>

            <router-view />
        </div>
    </div>
</template>