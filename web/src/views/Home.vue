<template>
  <div class="home overflow-hidden">
    <!-- HERO -->
    <header class="lg:flex w-full overflow-hidden">
      <div class="first-half my-20 lg:max-w-1/2 lg:grid">
        <div></div>
        <div class="container lg:px-0 lg:container-half-left">
          <h1 class="text-4xl md:text-5xl mb-6">
            Du bist nur 2 Minuten davon entfernt, deinen Bußgeldbescheid
            anzufechten.
          </h1>
          <p class="text-xl">
            Hol dir jetzt die BussgeldPrüfer App, um eine unverbindliche
            Ersteinschätzung zu erhalten – komplett kostenlos.
          </p>
        </div>
      </div>

      <div class="second-half bg-primary w-full my-1 grid">
        <div class="lg:px-0 container lg:container-half-right">
          <div class="flex flex-col sm:flex-row justify-center text-white font-light">
            <img
              class="w-56 self-center"
              src="../assets/img/iphone-x-splashscreen.webp"
              alt="BussgeldPrüfer App auf einem Handy."
            />
            <ul
              role="list"
              class="text-lg my-10 mb-3 self-center list-disc lg:ml-10 sm:ml-20"
            >
              <li class="mb-5">Kostenlose Ersteinschätzung</li>
              <li class="mb-5">in 90 Sekunden zum Ergebnis</li>
              <li>Digital ausführbar</li>
            </ul>
          </div>
          <p class="text-center mt-4 text-white font-light">
            überall - digital - verbunden
          </p>
          <div></div>
        </div>
      </div>
    </header>

    <CTA
      title="Bußgeldbescheid erhalten?"
      subtitle="Punkte in Flensburg? Führerschein weg? Fahrverbot? MPU-Test? Geblitzt?"
    />

    <!-- ? -->
    <section class="">
      <div
        class="container flex flex-col md:flex-row justify-center md:justify-between"
      >
        <div class="md:max-w-1/2">
          <h2 class="font-medium mb-5 text-3xl md:text-4xl">
            Mit dem BussgeldPrüfer fährst du richtig:
          </h2>
          <ul role="list" class="w-max mb-5">
            <li>Unverbindliche Ersteinschätzung in 90 Sekunden</li>
            <li>Kostenlose telefonische Beratung</li>
            <li>Schnelle Überprüfung Deiner Erfolgsaussichten</li>
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

    <Steps />

    <!-- ? -->
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

    <CTA
      title="Kostenlose Prüfung ob sich ein Einspruch gegen Deinen Bußgeldbescheid lohnt."
    />

    <!-- BLOG TEASER -->
    <section class="bg-primary my-1">
      <div class="container text-white text-center font-light">
        <h2 class="text-secondary font-normal mb-3">Bußgeld Ratgeber</h2>
        <p class="text-secondary mb-10">Aktuelle Neuigkeiten, Änderungen &amp; Urteile zum Thema Bußgeld</p>

        <BlogPreview imgsrc="/src/assets/img/alcohol.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein."/>

        <BlogPreview imgsrc="/src/assets/img/alcohol.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein."/>

        <router-link class="btn-primary text-white font-normal inline-block mt-10" to="/ratgeber">
          mehr erfahren
        </router-link>
      </div>
    </section>

    <!-- CLIENT FEEDBACK -->
    <section>
      <div class="container">
        <h2 class="text-secondary text-center mb-10">Kundenfeedback</h2>
        <div class="grid sm:grid-cols-3 gap-3 justify-center mb-8">
          <FeedbackStars :starLength="5" />
          <FeedbackStars :starLength="5" />
          <FeedbackStars :starLength="5" />
        </div>
        <div>
          <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." author="Melis Y." />
          <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." author="Melis Y." />
          <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." author="Melis Y." />
        </div>        
      </div>
    </section>

    <SocialMedia />
    <Warrants />
  </div>
</template>

<script>
import CTA from "../components/BasicCTA.vue"
import Steps from "../components/BasicSteps.vue"
import SocialMedia from "../components/BasicSocialMedia.vue"
import Warrants from "../components/BasicWarrants.vue"
import BlogPreview from "../components/BlogPreview.vue"
import FeedbackStars from "../components/FeedbackStars.vue"
import FeedbackText from "../components/FeedbackText.vue"

export default {
  name: "Home",
  components: {
    CTA,
    Steps,
    SocialMedia,
    Warrants,
    BlogPreview,
    FeedbackStars,
    FeedbackText
  },
};
</script>

<style scoped>
/*li:before {
    content: "";
    padding-right: 0.2em;
  }*/

/*.success ul {
    list-style-image: url("../assets/img/check-mark.svg");
  }*/

.success ul li:before {
  content: "";
}

.success ul li {
  padding-left: 2.4em;
  background: url("../assets/img/check-mark.svg") no-repeat 0 50%;
}

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
