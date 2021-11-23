<template>
      <section class="w-full overflow-hidden success lg:flex">
      <div class="my-20 mb-20 first-half lg:max-w-1/2 lg:grid lg:mb-0">
        <div></div>
        <div class="container lg:pr-0 lg:container-half-left">
          <h2 class="mb-10 text-3xl font-medium md:text-4xl">
            Maximiere Deine Erfolgsaussichten
          </h2>
          <p class="">
            Mit dem BussgeldPrüfer erhöhst Du Deine Chance erfolgreich gegen Deinen Bußgeldbescheid vorzugehen. Klicke jetzt auf <router-link :to="{ name: 'order' }" class="underline">“Prüfung
            Bußgeldbescheid”</router-link> um Deinen Bußgeldbescheid anzufechten.
          </p>
        </div>
      </div>

      <div class="grid w-full my-1 font-light second-half bg-primary text-secondary">
        <div
          class="container flex flex-col justify-center lg:pl-0 lg:container-half-right sm:flex-row-reverse"
        >
          <img
            class="w-56 mx-auto"
            src="../assets/img/img01_iphone12.png"
            alt="BussgeldPrüfer App"
          />
          <ul role="list" class="mx-auto mt-10 mb-3 lg:mr-5 sm:self-center">
            <li class="mb-5">Kompetente<br />Beratung</li>
            <li class="mb-5">Vollständige<br />Entlastung</li>
            <li>Schnell &amp;<br />Unkompliziert</li>
          </ul>
        </div>
        <div></div>
      </div>
    </section>
</template>

<style scoped>

.success ul li:before {
  content: "";
}

.success ul li {
  padding-left: 2.4em;
  background: url("../assets/img/check-mark.svg") no-repeat 0 50%;
}

@media (min-width: 1024px) {
  .first-half {
    grid-template-columns: calc(50vw - 512px) calc(512px - 1.5rem);
  }

  .second-half {
    grid-template-columns: calc(512px - 1.5rem) calc(50vw - 512px);
  }
}

@media (min-width: 1280px) {
  .first-half {
    grid-template-columns: calc(50vw - 640px) calc(640px - 1.5rem);
  }

  .second-half {
    grid-template-columns: calc(640px - 1.5rem) calc(50vw - 640px);
  }
}

@media (min-width: 1536px) {
  .first-half {
    grid-template-columns: calc(50vw - 768px) calc(768px - 1.5rem);
  }

  .second-half {
    grid-template-columns: calc(768px - 1.5rem) calc(50vw - 768px);
  }
}
</style>
