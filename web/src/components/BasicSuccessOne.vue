<template>
  <section class="">
      <div
        class="container flex flex-col justify-center md:flex-row-reverse md:justify-between"
      >
        <div class="md:max-w-1/2">
          <h2 class="mb-5 text-3xl font-medium md:text-4xl">
            Mit dem BussgeldPrüfer fährst Du richtig:
          </h2>
          <ul role="list" class="mb-5 list-disc list-inside w-max">
            <li>Unverbindliche Ersteinschätzung in 90 Sekunden</li>
            <li>Kostenlose anwaltliche Ersteinschätzung</li>
            <li>Schnelle Prüfung Deiner Erfolgsaussichten</li>
          </ul>
        </div>

        <div class="relative mx-auto md:max-w-1/2 h-52 w-96">
          <div
            class="absolute grid w-32 h-32 text-center bg-white border-2 rounded-full circle-one place-items-center border-secondary"
          >
            <p>Kostenlose Erstberatung</p>
          </div>
          <div
            class="absolute grid w-32 h-32 text-center bg-white border-2 rounded-full circle-two place-items-center border-secondary"
          >
            <p>Anwaltliche Prüfung</p>
          </div>
          <div
            class="absolute grid w-32 h-32 text-center bg-white border-2 rounded-full circle-three place-items-center border-secondary"
          >
            <p>binnen 24 Std. Rückmeldung</p>
          </div>
        </div>
      </div>
    </section>
</template>

<style scoped>
.circle-two {
  left: 108px;
  top: 60px;
  z-index: 1;
}

.circle-three {
  left: 210px;
  top: 20px;
  z-index: 2;
}
</style>