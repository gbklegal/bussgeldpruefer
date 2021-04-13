<template>
  <div class="profile-mail sm:flex">
    <div class="sm:mr-6 bg-primary text-white font-light rounded-sm w-max mb-4 sm:mb-0">
      <nav aria-label="Navigation innerhalb Posteingang im Profil">
        <ul>
          <li class="py-2 pt-3 px-2">
            <router-link :to="{ name: 'profile-mail-court' }">Gerichtliche<br> Angelegenheiten</router-link>
          </li>
          <li class="py-2 px-2">
            <router-link :to="{ name: 'profile-mail-outside-court' }">Außergerichtliche<br> Angelegenheiten</router-link>
          </li>
          <li class="py-2 px-2">
            <router-link :to="{ name: 'profile-mail-else' }">Sonstiges</router-link>
          </li>
          <li class="py-2 px-2">
            <router-link :to="{ name: 'profile-mail-sent' }">Gesendet</router-link>
          </li>
          <li class="py-2 px-2">
            <router-link :to="{ name: 'profile-mail-sent' }">
              <img class="w-5 inline" src="/src/assets/img/star-outline.svg" alt="Stern-Icon.">
              Markiert
            </router-link>
          </li>
          <li class="py-2 pb-3 px-2">
            <router-link class="bg-white hover:bg-gray-100 text-secondary" :to="{ name: 'profile-mail-new-message' }">
            <img class="w-5 inline" src="/src/assets/img/pen.svg" alt="Stift-Icon">
            schreiben
            </router-link>
          </li>
        </ul>
      </nav>
    </div>
    <div>
      <router-view />
    </div>
  </div>
</template>
