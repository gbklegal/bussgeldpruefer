<template>
    <div class="container profile">
        <h1 class="text-secondary mb-10">Mein Profil</h1>
        <div class="md:flex">

            <nav class="md:mr-4 md:mb-0 mb-4" aria-label="Navigation im Profil">
                <ul class="w-max">
                    <li class="border-t-2 border-r-2 border-gray-200 p-3 pl-0 rounded-sm">
                        <router-link :to="{ name: 'profile-mail'}">
                        <img class="mr-1 w-6 inline bg-secondary rounded-full p-2 h-10 w-10" src="/src/assets/img/mail.svg" alt="EMail Icon.">
                        Online Posteingang
                        </router-link>
                    </li>
                    <li class="border-t-2 border-r-2 border-gray-200 p-3 pl-0">
                        <router-link class="flex" :to="{ name: 'profile-status'}">
                        <img class="mr-1 w-6 inline bg-secondary rounded-full p-2 h-10 w-10" src="/src/assets/img/refresh.svg" alt="Neu Laden Icon.">                        
                        Überprüfe den aktuellen<br> Status Deines Falls
                        </router-link>
                    </li>
                    <li class="border-t-2 border-r-2 border-gray-200 border-b-2  p-3 pl-0 rounded-sm">
                        <router-link :to="{ name: 'profile-documents'}">
                        <img class="mr-1 w-6 inline bg-secondary rounded-full p-2 h-10 w-10" src="/src/assets/img/cloud-upload.svg" alt="EMail Icon.">
                        Dokumenten Übersicht
                        </router-link>
                    </li>
                </ul>
            </nav>

            <router-view />
        </div>
    </div>
</template>