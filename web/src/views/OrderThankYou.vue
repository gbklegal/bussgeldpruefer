<template>
    <div class="container">
        <h1 class="text-secondary">Prüfung Bußgeldbescheid</h1>
        <p>Unverbindliche Prüfung durch Anwalt - Antwort in 24 Stunden</p>
        <OrderProgress text="Schritt 6 von 6" percentage="100" />        

        <p class="mt-8 text-xl">Geschafft!</p>
        <p class="text-xl">Dein Antrag wurde erfolgreich eingereicht.</p>
        <img src="/src/assets/img/confetti.svg" class="w-20 my-4 ml-20" alt="Icon mit Konfetti.">
        <p class="text-secondary mt-6 mb-4">Was passiert als Nächstes?</p>
        <ol class="list-decimal ml-5 mb-6">
            <li>Du erhältst nun eine E-Mail mit allen wichtigen Daten.</li>
            <li>Die Anwaltskanzlei meldet sich bei dir in 24 Stunden.(Es entstehen keine Kosten.)</li>
        </ol>
        <CaseProgress percentage="25" />
        <p class="mt-6 mb-4">Du hast was vergessen? Kein Problem! Antworte einfach auf die BussgeldPrüfer E-Mail und wir werden uns darum kümmern.</p>
        <a href="mailto:dialog@bussgeldpruefer.de">dialog@bussgeldpruefer.de</a>

    </div>
</template>
<script>   
import OrderProgress from '../components/OrderProgress.vue'
import CaseProgress from '../components/OrderCaseProgress.vue'

import { ref } from 'vue'

export default {
    components: {
        OrderProgress,
        CaseProgress
    },
    
    setup () {    
        return { 

        }
    }
}
</script>
<style lang="scss" scoped>

</style>
