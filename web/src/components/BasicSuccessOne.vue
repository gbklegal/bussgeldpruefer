<template>
  <section class="">
      <div
        class="container flex flex-col md:flex-row-reverse justify-center md:justify-between"
      >
        <div class="md:max-w-1/2">
          <h2 class="font-medium mb-5 text-3xl md:text-4xl">
            Mit dem BussgeldPrüfer fährst du richtig:
          </h2>
          <ul role="list" class="w-max mb-5 list-disc list-inside">
            <li>Unverbindliche Ersteinschätzung in 90 Sekunden</li>
            <li>Kostenlose anwaltliche Ersteinschätzung</li>
            <li>Schnelle Prüfung Deiner Erfolgsaussichten</li>
          </ul>
        </div>

        <div class="md:max-w-1/2 relative mx-auto h-52 w-96">
          <div
            class="circle-one bg-white grid place-items-center absolute text-center rounded-full h-32 w-32 border-2 border-secondary"
          >
            <p>Kostenlose Erstberatung</p>
          </div>
          <div
            class="circle-two bg-white grid place-items-center absolute text-center rounded-full h-32 w-32 border-2 border-secondary"
          >
            <p>Anwaltliche Prüfung</p>
          </div>
          <div
            class="circle-three bg-white grid place-items-center absolute text-center rounded-full h-32 w-32 border-2 border-secondary"
          >
            <p>in 24 Std. Rückmeldung</p>
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