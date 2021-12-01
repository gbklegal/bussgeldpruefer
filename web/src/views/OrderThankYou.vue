<template>
    <div class="container">
        <h1 class="text-secondary">Prüfung Bußgeldbescheid</h1>
        <p>Unverbindliche Prüfung durch Anwalt - Antwort binnen 24 Stunden</p>
        <OrderProgress v-if="false" :currentNumber="6" :maxNumber="6" :percentage="100" />        

        <p class="mt-8 text-xl">Geschafft!</p>
        <p class="text-xl">Dein Antrag wurde erfolgreich eingereicht.</p>
        <img src="/src/assets/img/confetti.svg" class="w-20 my-4 ml-20" alt="Icon mit Konfetti.">
        <p class="mt-6 mb-4 text-secondary">Was passiert als Nächstes?</p>
        <ol class="relative mb-10 ml-5">
            <li class="mb-2">Du erhältst nun eine E-Mail mit allen wichtigen Daten.</li>
            <li>Die Anwaltskanzlei meldet sich bei dir binnen 24 Stunden. (Es entstehen keine Kosten.)</li>
        </ol>
        <CaseProgress />
        <p class="mt-10 mb-4">Du hast was vergessen? Kein Problem! Antworte einfach auf die BussgeldPrüfer E-Mail und wir werden uns darum kümmern.</p>
        <a href="mailto:dialog@bussgeldpruefer.com">dialog@bussgeldpruefer.com</a>
    </div>
</template>


<script>
import OrderProgress from '../components/OrderProgress.vue'
import CaseProgress from '../components/OrderCaseProgress.vue'

export default {
    components: {
        OrderProgress,
        CaseProgress
    },

    data() {
        return {
            trackingScript: null,
            trackingScriptSrc: null,
        }
    },
    
    mounted() {
        let publisherId = this.$route.query.p_id;
        let orderNumber = this.$route.query.order_number;

        if (!publisherId || !orderNumber)
            // redirect to home
            this.$router.push({
                name: 'home'
            });

        if (publisherId === '4231') {
            this.trackingScript = document.createElement('script');
            this.trackingScript.innerText = 'var faOrderID = "'+orderNumber+'"; var faProgramID = "1579"; var faCategory = "bussgeld";';
            document.body.appendChild(this.trackingScript);

            this.trackingScriptSrc = document.createElement('script');
            this.trackingScriptSrc.src = 'https://bussgeldpruefer.com/wp-content/themes/onepress-child/testscript.js'; // TODO: replace tracking file url
            document.body.appendChild(this.trackingScriptSrc);
        }
    },

    beforeRouteLeave(to, from, next) {
        if (this.trackingScript)
            document.body.removeChild(this.trackingScript);
        if (this.trackingScriptSrc)
        document.body.removeChild(this.trackingScriptSrc);

        next();
    }
}
</script>


<style lang="scss" scoped>

ol {
    counter-reset: next-steps;
}

ol li {
    counter-increment: next-steps;
}

ol li::before {
    content: counter(next-steps) ". ";
    color: #5CC8C5;
    position: absolute;
    left: -1em;
}
</style>
