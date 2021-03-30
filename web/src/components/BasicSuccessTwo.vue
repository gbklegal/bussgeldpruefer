<template>
      <section class="success lg:flex w-full overflow-hidden">
      <div class="first-half my-20 lg:max-w-1/2 lg:grid mb-20 lg:mb-0">
        <div></div>
        <div class="container lg:pr-0 lg:container-half-left">
          <h2 class="font-medium mb-10 text-3xl md:text-4xl">
            Maximiere deine Erfolgsaussichten
          </h2>
          <p class="">
            Mit dem BussgeldPrüfer erhöhst du deine Chance erfolgreich gegen
            deinen Bußgeldbescheid vorzugehen. Klicke jetzt auf <router-link to="/bussgeldbescheid-pruefen" class="underline">“Prüfung
            Bußgeldbescheid”</router-link> um deinen Bußgeldbescheid anzufechten.
          </p>
        </div>
      </div>

      <div class="second-half grid bg-primary w-full my-1 text-secondary font-light">
        <div
          class="container lg:pl-0 lg:container-half-right sm:flex-row-reverse flex flex-col justify-center"
        >
          <img
            class="w-56 mx-auto"
            src="../assets/img/iphone-x-splashscreen.webp"
            alt="BussgeldPrüfer App auf einem Handy."
          />
          <ul role="list" class="mt-10 mb-3 mx-auto lg:mr-5 sm:self-center">
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
