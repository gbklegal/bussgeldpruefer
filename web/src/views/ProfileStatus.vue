<template>
<div>
<div class="flex">
  <div class="flex flex-col">
    <div class="bg-gray-200 shadow-inner rounded-sm h-96 w-5">
      <div class="bg-secondary rounded-sm w-5 h-3/4">
      </div>
    </div>
  </div>
  <div class="ml-5">
    <div class="text-center flex">
      <img class="w-20 " src="/src/assets/img/assignment.svg" alt="Icon mit Dokumenten.">
      <span class="inline-block mt-10 ml-5">Einreichung von Dokumenten</span>
    </div>

    <div class="text-center flex">
      <img class="w-20 mt-3" src="/src/assets/img/communication.svg" alt="Icon mit Personen.">
      <span class="inline-block mt-10 ml-5">Fallbesprechung mit Kanzlei</span>
    </div>

    <div>
      <div class="flex text-center">
        <img class="w-20 mt-3" src="/src/assets/img/innovation.svg" alt="Icon mit Lupe.">
        <span class="inline-block mt-10 ml-5">Überprüfung /Recherche</span>
      </div>
      <p class="text-sm text-secondary ml-24">Es werden Dokumente von Dir benötigt. Überprüfe deinen Posteingang.</p>
    </div>

    <div class="text-center flex">
      <img class="w-20 mt-3" src="/src/assets/img/sentence.svg" alt="Icon mit Richterhammer">
      <span class="inline-block mt-10 ml-5">Urteil</span>
    </div>
  </div>
</div>
<div class="mt-10">
    <p class="text-xl">Du hast Fragen zu deinem Status?</p>
    <p>Dann kontaktiere uns. Wir werden uns schnellstmöglich darum kümmern.</p>
    <router-link to="/kontakt" class="btn-secondary mt-4 inline-block">Kontakt</router-link>
</div>
</div>


</template>