<template>
  <Hero title="Messungen mit Traffistar S350 unzulässig?" subtitle="In der Vergangenheit hat sich gezeigt, dass Messungen mit der TraffiStar S350 durchaus Probleme mit sich bringen kann. In vielen deutschen Städten sind die S350 Blitzer daher aktuell auch wieder außer Betrieb, denn die Geschwindigkeitsmessung mit dem Blitzer TraffiStar S350 sind aktuell eher als mangelhaft und fehlerhaft einzustufen." imgSrc="/src/assets/img/redlight.jpg" />
  <BasicCTA smallText="überall - digital - verbunden" title="Bußgeldbescheid erhalten?" subtitle="Punkte in Flensburg? Führerschein weg? Fahrverbot? MPU-Test? Geblitzt?" />
  <TextOne />
  <Steps />
  <Success />
  <BasicCTA title="Kostenlose Prüfung ob sich ein Einspruch gegen Deinen Bußgeldbescheid lohnt." />

  <!-- Info -->
  <section class="info lg:flex w-full overflow-hidden">
    <div class="first-half bg-primary my-1 lg:max-w-1/2 lg:grid">
      <div></div>
      <div class="container lg:px-0 lg:container-half-left font-light text-white ">
        <ul>
          <li class="mb-6">
            <span class="text-secondary text-xl mb-4 inline-block">Geblitzt vom TraffiStar S350: Lohnt ein Einspruch?</span>
            <p>Im Einzelfall kann ein Einspruch definitiv sinnvoll sein, denn die Messgenauigkeit des TraffiStar S 350 wurde mittlerweile von mehreren Gerichten in Zweifel gezogen.</p>
          </li>
          <li class="mb-6">
            <span class="text-secondary text-xl mb-4 inline-block">TraffiStar S350: Wie funktioniert der Laser-Blitzer?</span>
            <p>Das Lasergeschwindigkeitsmessgerät wirft einen Laserteppich auf den zu messenden Straßenabschnitt. So kann der TraffiStar die Geschwindigkeit der durchfahrenden Fahrzeuge berechnen. Bei einer Geschwindigkeitsüberschreitung löst anschließenden ein Blitzer aus, der das gemessene Fahrzeug aufzeichnet.</p>
          </li>
          <li class="mb-6">
            <span class="text-secondary text-xl mb-4 inline-block">Vom TraffiStar S350 geblitzt: Welche Sanktionen drohen? </span>
            <p>Eine Geschwindigkeitsüberschreitung kann mit Bußgeldern zwischen 10 und 680 Euro geahndet werden. Punkte drohen in der Regel ab 21 km/h zu viel. Ein Fahrverbot ist regulär ab 31 km/h innerorts und 41 km/h außerorts zu schnell zu erwarten.</p>
          </li>
          <li class="mb-6">
            <span class="text-secondary text-xl mb-4 inline-block">Wer wir sind</span>
            <p>/// GBK Legal Kanzlei wird Dich deutschlandweit vertreten. Wir sind der richtige Ansprechpartner, wenn Du rechtliche Probleme im Verkehr hast, und natürlich in allen anderen Angelegenheiten. Überzeuge Dich selbst von unserer Kompetenz.</p>
          </li>
        </ul>
      </div>
    </div>

    <div class="second-half w-full my-1 grid">
      <div class="lg:pl-6 lg:px-0 container lg:container-half-right">
        <div class="">
          <h2 class="text-xl md:text-2xl font-bold">Akzeptiere deinen Bußgeldbescheid nicht voreilig.</h2>
          <ol
            role="list"
            class="text-lg my-10 mb-3 self-center ml-10"
          >
            <li class="mb-5">Mit Hilfe des Quick-Checks erhältst Du eine unverbindliche Er steinschätzung deines Falls.</li>
            <li class="mb-5">Mit Hilfe des Quick-Checks erhältst Du eine unverbindliche Ersteinschätzung deines Falls.</li>
            <li>Nur mit Deinem Verständnis wird die Partnerkanzlei Einspruch einlegen. Auf diese Weise besteht die Chance deine Strafe zu verringern (Bußgeld, Punkte und Fahrverbot abwenden). </li>
          </ol>
        </div>
        <div></div>
      </div>
    </div>
  </section>

  <!-- ClientFeedback -->
  <section>
    <div class="container">
      <h2 class="text-secondary text-center mb-10">Kundenbewertungen</h2>
      <div class="md:grid md:grid-cols-3 md:gap-5 md:text-center">
        <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." />
        <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." />
        <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." />
      </div>        
    </div>
  </section>
</template>

<script>
import Hero from '../components/TopicsHero.vue'
import BasicCTA from '../components/BasicCTA.vue'
import TextOne from '../components/BasicSuccessOne.vue'
import Steps from '../components/BasicSteps.vue'
import Success from '../components/BasicSuccessTwo.vue'
import FeedbackText from '../components/FeedbackText.vue'

export default {
    components: {
        Hero,
        BasicCTA,
        TextOne,
        Steps,
        Success,
        FeedbackText
    }
}
</script>

<style lang="scss" scoped>
.info .second-half ol {
  counter-reset: info-counter;

  li {
    counter-increment: info-counter;
    position: relative;

    &::before {
      content: counter(info-counter);
      position: absolute;
      left: -2.5em;
      background-color: #5CC8C5;
      color: #FFF;
      border-radius: 50%;
      width: 2em;
      height: 2em;
      text-align: center;
      line-height: 2em;
    }
  }
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
