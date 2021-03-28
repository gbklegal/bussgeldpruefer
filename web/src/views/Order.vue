<template>
    <div class="container">
        <h1 class="">Prüfung Bußgeldbescheid</h1>
        <p>Unverbindliche Prüfung durch Anwalt - Antwort in 24 Stunden</p>
        <form>

            <OrderProgress :text="progressText[activeTab]" :percentage="progressPercentage" />

            <div :class="{'sr-only':(activeTab !== 0)}" class="tab">
                <fieldset class="first-step">
                    <legend>Wähle den Verstoß aus</legend>

                    <div class="grid sm:grid-cols-2 md:grid-cols-3">
                        <label for="speed" class="speed cursor-pointer m-3 h-40 rounded pt-16 text-center border-2 border-white hover:border-secondary">
                            <input type="radio" name="case" id="speed" value="speed" class="sr-only">
                        <span class="text-xl">zu schnell</span></label>

                        <label for="redlight" class="redlight cursor-pointer m-3 h-40 rounded pt-16 text-center border-2 border-white hover:border-secondary">
                            <input type="radio" name="case" id="redlight" value="redlight" class="sr-only">
                        <span class="text-xl">Rotlicht</span></label>
                        
                        <label for="distance" class="distance cursor-pointer m-3 h-40 rounded pt-16 text-center border-2 border-white hover:border-secondary">
                            <input type="radio" name="case" id="distance" value="distance" class="sr-only">
                        <span class="text-xl">Abstand</span></label>

                        <label for="alkohol" class="alcohol cursor-pointer m-3 h-40 rounded pt-16 text-center border-2 border-white hover:border-secondary">
                            <input type="radio" name="case" id="alkohol" value="alkohol" class="sr-only">                    
                        <span class="text-xl">Alkohol</span></label>

                        <label for="phone" class="phone cursor-pointer m-3 h-40 rounded pt-16 text-center border-2 border-white hover:border-secondary">            
                            <input type="radio" name="case" id="phone" value="phone" class="sr-only">
                        <span class="text-xl">Telefon</span></label>

                        <label for="parking" class="parking cursor-pointer m-3 h-40 rounded pt-16 text-center border-2 border-white hover:border-secondary">
                            <input type="radio" name="case" id="parking" value="parking" class="sr-only">
                        <span class="text-xl">Parken</span></label>
                    </div>
 
                </fieldset>
            </div>   

            <div :class="{'sr-only':(activeTab !== 1)}" class="tab">
                <fieldset>
                    <legend>Hast du eine Rechtschutzversicherung, die den Bereich Verkehr abdeckt?</legend>

                    <label class="block" for="insured">
                        <input type="radio" name="insurance" id="insured" value="insured">
                    Ja</label>
                    
                    <label class="block" for="not-insured">
                        <input type="radio" name="insurance" id="not-insured" value="not-insured">
                    Nein</label>

                </fieldset>
            </div>

            <div :class="{'sr-only':(activeTab !== 2)}" class="tab">
                <fieldset>
                    <legend>Welches behördliche Schreiben hast du zuletzt erhalten?</legend>
                    <label for="1" class="block">
                        <input type="radio" name="urgency" id="1" value="1">
                    Zeugenfragebogen</label>
                    
                    <label for="2" class="block">
                        <input type="radio" name="urgency" id="2" value="2">
                    Anhörungsbogen</label>

                    <label for="3" class="block">
                        <input type="radio" name="urgency" id="3" value="3">
                    Bußgeldbescheid</label>

                    <label for="4" class="block">
                        <input type="radio" name="urgency" id="4" value="4">
                    Keines / Unklar</label>
                </fieldset>
            </div>

            <div :class="{'sr-only':(activeTab !== 3)}" class="tab">
                <fieldset>
                <!-- TODO: Unterlagen hochladen: redirect to an upload page? or add it her? -->
                    <p>Dokumente hochladen</p>
                </fieldset>
            </div>

            <!-- TODO: if user is logged in -> resume, else: redirect to login / signup site then redirect back -->

            <div :class="{'sr-only':(activeTab !== 4)}" class="tab">
                <fieldset>
                <!-- TODO: accept AGB, Datenschutz, Schweigepflicht -->
                <p>Akzeptieren und bestellen</p>
                </fieldset>
            </div>

            <div :class="{'sr-only':(activeTab !== 5)}" class="tab">
                <fieldset>
                    <p>Geschafft</p>
                </fieldset>
            </div>

            <div class="controls mt-6 flex items-center justify-center">
                <button v-if="(activeTab >= 1)" @click.prevent="decrement()" class="btn-secondary mr-4">Zurück</button>
                <button v-if="(activeTab <= 4)" @click.prevent="increment()" class="btn-secondary mr-4">Weiter</button>
                <button @click.prevent="reset()" class="btn-secondary block">
                    <svg role="img" aria-labelledby="resetForm" class="w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <title id="resetForm">Neu starten</title>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                    </svg>
                </button>
            </div>
        </form>

    </div>
</template>
<script>   
import OrderProgress from '../components/OrderProgress.vue'

import { ref } from 'vue'

export default {
    components: {
        OrderProgress
    },
    
    // hide all .tab visually.
    // change this with class when activeTab = specific number
    setup () {
        const activeTab = ref(0)
        //console.log(activeTab.value)
        const progressPercentage = ref(100/6)

        const progressText = [
            'Schritt 1 von 6',
            'Schritt 2 von 6',
            'Schritt 3 von 6',
            'Schritt 4 von 6',
            'Schritt 5 von 6',
            'Schritt 6 von 6'
        ]

        function increment() {
            activeTab.value ++
            progressPercentage.value += 100/6
        }

        function decrement() {
            activeTab.value --
            progressPercentage.value -= 100/6
        }

        function reset() {
            activeTab.value = 0
            progressPercentage.value = 100/6
        }

        return { 
            activeTab,
            progressPercentage,
            progressText,
            increment,
            decrement,
            reset
        }
    }
}
</script>
<style scoped>
.tab {
    margin-top: 2em;
}

legend {
    font-size: 1.25rem;
    line-height: 1.75rem;
}

.first-step label {
    background-color: #183B63;
    color: #fff;
    background-position: center;
    background-size: cover;
    position: relative;
}

.first-step label:after {
    position: absolute;
    content: "";
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: #001329;
    opacity: 0.5;
}

.first-step label span {
    z-index: 99;
    opacity: 1;
    position: relative;
}

.speed {
    background-image: url("../assets/img/speed.jpg");
}

.redlight {
    background-image: url('../assets/img/redlight.jpg');
}

.distance {
    background-image: url('../assets/img/distance.jpg');
}

.alcohol {
    background-image: url('../assets/img/alcohol.jpg');
}

.phone {
    background-image: url('../assets/img/phone.jpg');
}

.parking {
    background-image: url('../assets/img/parking.jpg');
}
</style>
