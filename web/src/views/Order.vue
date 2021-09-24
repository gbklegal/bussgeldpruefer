<template>
    <Modal
        title="Formular jetzt zurücksetzen?"
        text="Sind Sie sicher, dass Sie Ihre derzeitige Eingabe zurücksetzten wollen?"
        button="Ja"
        cancel="Nein"
        mode="warning"
        :callback="modalResult"
    />
    <div class="container">
        <h1 class="text-secondary">Prüfung Bußgeldbescheid</h1>
        <p>Unverbindliche Prüfung durch Anwalt - Antwort binnen 24 Stunden</p>
        <form @submit.prevent>

            <OrderProgress :currentNumber="activeTab+1" :maxNumber="maxSteps" :percentage="progressPercentage" />

            <div :class="{'sr-only':(activeTab !== 0)}" class="tab">
                <fieldset class="first-step">
                    <legend>Wähle den Verstoß aus</legend>

                    <div class="grid sm:grid-cols-2 md:grid-cols-3">

                        <input type="radio" name="case" id="speed" value="speed" v-model="violation" class="sr-only">
                        <label for="speed" class="speed cursor-pointer m-3 h-40 rounded pt-16 text-center border-4 border-white hover:border-secondary checked:border-secondary">
                        <span class="text-xl">zu schnell</span></label>

                        <input type="radio" name="case" id="redlight" value="redlight" v-model="violation" class="sr-only">                        
                        <label for="redlight" class="redlight cursor-pointer m-3 h-40 rounded pt-16 text-center border-4 border-white hover:border-secondary">
                        <span class="text-xl">Rotlicht</span></label>
                        
                        <input type="radio" name="case" id="distance" value="distance" v-model="violation" class="sr-only">
                        <label for="distance" class="distance cursor-pointer m-3 h-40 rounded pt-16 text-center border-4 border-white hover:border-secondary">
                        <span class="text-xl">Abstand</span></label>

                        <input type="radio" name="case" id="alcohol" value="alcohol" v-model="violation" class="sr-only">
                        <label for="alcohol" class="alcohol cursor-pointer m-3 h-40 rounded pt-16 text-center border-4 border-white hover:border-secondary">                   
                        <span class="text-xl">Alkohol</span></label>

                        <input type="radio" name="case" id="phone" value="phone" v-model="violation" class="sr-only">
                        <label for="phone" class="phone cursor-pointer m-3 h-40 rounded pt-16 text-center border-4 border-white hover:border-secondary">            
                        <span class="text-xl">Telefon</span></label>

                        <input type="radio" name="case" id="parking" value="parking" v-model="violation" class="sr-only">
                        <label for="parking" class="parking cursor-pointer m-3 h-40 rounded pt-16 text-center border-4 border-white hover:border-secondary">
                        <span class="text-xl">Parken</span></label>
                    </div>
                    <!-- for debugging
                    <span>{{ violation }}</span>
                    -->
 
                </fieldset>
            </div>   

            <div :class="{'sr-only':(activeTab !== 1)}" class="tab">
                <fieldset>
                    <legend class="mb-6">Hast du eine Rechtschutzversicherung, die den Bereich Verkehr abdeckt?</legend>

                    <label class="block" for="insured">
                        <input type="radio" name="insurance" id="insured" value="insured" v-model="insurance" class="mb-3">
                    Ja</label>
                    
                    <label class="block" for="not-insured">
                        <input type="radio" name="insurance" id="not-insured" value="not-insured" v-model="insurance">
                    Nein</label>
                </fieldset>

                <!-- for debugging
                <span>{{ insurance }}</span> -->
            </div>

            <div :class="{'sr-only':(activeTab !== 2)}" class="tab">
                <fieldset>
                    <legend class="mb-6">Welches behördliche Schreiben hast du zuletzt erhalten?</legend>
                    <label for="1" class="block mb-3">
                        <input type="radio" name="urgency" id="1" value="1" v-model="urgency">
                    Zeugenfragebogen</label>
                    
                    <label for="2" class="block mb-3">
                        <input type="radio" name="urgency" id="2" value="2" v-model="urgency">
                    Anhörungsbogen</label>

                    <label for="3" class="block mb-3">
                        <input type="radio" name="urgency" id="3" value="3" v-model="urgency">
                    Bußgeldbescheid</label>

                    <label for="4" class="block">
                        <input type="radio" name="urgency" id="4" value="4" v-model="urgency">
                    Keines / Unklar</label>
                </fieldset>
                <!-- for debugging
                <span>{{ urgency }}</span> -->
            </div>

            <div :class="{'sr-only':(activeTab !== 3)}" class="tab">              
                <label for="document" class="mb-6 text-xl block">Dokumente Hochladen</label>
                <input type="file" name="document" id="document" multiple>                
            </div>

            <!-- <div :class="{'sr-only':(activeTab !== 4)}" class="tab text-center">
                <p class="mb-6">Um Deinen Bußgeldbescheid prüfen zu lassen <router-link class="underline" to="/login">melde dich an</router-link>. Oder erstelle einen <router-link class="underline" to="/registrieren">Account</router-link>.</p>
                <p @click="submitOrder()"><br>weiter</p>
            </div> -->

            <div class="controls mt-6 flex items-center justify-center">
                <button v-if="(activeTab >= 1)" @click.prevent="decrement()" class="btn-secondary mr-4">Zurück</button>
                <button v-if="(activeTab <= 2)" @click.prevent="increment()" class="btn-secondary mr-4">Weiter</button>
                <button v-if="(activeTab == 3)" @click.prevent="submitOrder()" class="btn-secondary mr-4">Abschließen</button>
                <button @click.prevent="requestReset()" class="btn-secondary block">
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
import Modal from '../components/BasicModal.vue'

import { ref } from 'vue'
import { useRouter, useRoute } from 'vue-router'

export default {
    components: {
        OrderProgress,
        Modal
    },
    
    setup () {
        // max number of steps
        const maxSteps = 5;
        // hide all .tab visually.
        // change this with class when activeTab = specific number
        const activeTab = ref(0)
        //console.log(activeTab.value)
        const progressPercentage = ref(100 / maxSteps)

        // const progressText = [
        //     'Schritt 1 von 6',
        //     'Schritt 2 von 6',
        //     'Schritt 3 von 6',
        //     'Schritt 4 von 6',
        //     'Schritt 5 von 6',
        //     'Schritt 6 von 6'
        // ]

        // form data:
        const violation = ref('')
        const insurance = ref('')
        const urgency = ref('')

        // router
        const router = useRouter()
        const route = useRoute()

        function increment() {
            activeTab.value ++
            progressPercentage.value += 100 / maxSteps
        }

        function decrement() {
            activeTab.value --
            progressPercentage.value -= 100 / maxSteps
        }

        function reset() {
            activeTab.value = 0
            progressPercentage.value = 100 / maxSteps
        }

        function requestReset() {
            Modal.methods.fadeIn();
        }

        function submitOrder() {
            router.push({name: 'order-thank-you'})
        }

        return { 
            activeTab,
            maxSteps,
            progressPercentage,
            // progressText,
            increment,
            decrement,
            reset,
            requestReset,
            submitOrder,
            violation,
            insurance,
            urgency
        }
    },
    methods: {
        modalResult: function(confirmation) {
            if (confirmation) this.reset();
        }
    }
}
</script>
<style lang="scss" scoped>
label {
    transition: border .2s ease;
}

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

.first-step input[type=radio]:checked + label {
    border-color: #5CC8C5;
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