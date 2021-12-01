<template>
    <Modal
        id="resetFormModal"
        title="Formular jetzt zurücksetzen?"
        text="Sind Sie sicher, dass Sie Ihre derzeitige Eingabe zurücksetzten wollen?"
        button="Ja"
        cancel="Nein"
        mode="warning"
        :callback="modalResult"
    />
    <Modal
        id="legalInfoModal"
        title="Info"
        text='<p class="pb-4">Die GDF GmbH vermittelt als Betreiber dieser Webseite selbst keine Versicherung und ist für die Inhalte der verlinkten Webseite nicht verantwortlich.</p><p class="pb-4">Verantwortlicher Versicherungsmakler für das Versicherungsangebot ist:</p><p class="pb-4">Herr Thomas Wirth, Rothenburger Straße 116, 90439 Nürnberg,<br> E-Mail Thomas.Wirth@arag-partner.de<br> Gebundener Versicherungsvermittler nach § 34d Abs.4 GewO</p><p class="pb-4">Deutscher Industrie- und Handelskammertag (DIHK) e.V.<br> Breite Straße 29, 10178 Berlin<br> Telefon 0 18 06 00 58 50 (0,20 EUR/Anruf aus dem deutschen Festnetz; höchstens 60 Cent/Anruf aus  Mobilfunknetzen)<br> www.vermittlerregister.info</p><p class="pb-4">IHK-Register-Nr. D-LDKK-PB9YO-76</p><p class="pb-4">Beschwerde-/Schlichtungsstelle Versicherungsombudsmann e.V.<br> Postfach 080632, 10006 Berlin Telefon 0 18 04 22 44 24,<br> Fax 0 18 04 22 44 25 für 0,20 EUR /Anruf*/Fax<br> * höchstens 0,60 EUR/Min. aus Mobilfunknetzen<br> E-Mail beschwerde@versicherungsombudsmann.de</p>'
        :isHTML="true"
        button="schließen"
        mode="info"
    />
    <Modal
        id="missingRequiredModal"
        :title="missingRequiredModalTitle"
        :text="missingRequiredModalText"
        :isHTML="true"
        button="OK"
        mode="warning"
    />
    <Modal
        id="submitIssueModal"
        :title="submitIssueModalTitle"
        text="Fehler beim Versenden der Daten, bitte versuche es erneut."
        button="OK"
        mode="error"
    />
    <div class="container">
        <h1 class="text-secondary">Prüfung Bußgeldbescheid</h1>
        <p>Unverbindliche Prüfung durch Anwalt - Antwort binnen 24 Stunden</p>
        <form name="orderForm" @submit.prevent>

            <OrderProgress :currentNumber="activeTab+1" :maxNumber="maxSteps" :percentage="progressPercentage" />

            <div :class="{'hidden':(activeTab !== 0)}" class="tab">
                <fieldset class="first-step">
                    <legend>Wähle den Verstoß aus</legend>

                    <div class="grid gap-3 sm:grid-cols-2 md:grid-cols-3">

                        <input type="radio" name="order[violation]" id="speed" value="Geschwindkeit" v-model="violation" class="hidden" required>
                        <label for="speed" class="h-40 text-center border-4 border-white rounded cursor-pointer speed hover:border-secondary">
                        <span class="text-xl">Geschwindkeit</span></label>

                        <input type="radio" name="order[violation]" id="redlight" value="Rotlicht" v-model="violation" class="hidden" required>
                        <label for="redlight" class="h-40 text-center border-4 border-white rounded cursor-pointer redlight hover:border-secondary">
                        <span class="text-xl">Rotlicht</span></label>
                        
                        <input type="radio" name="order[violation]" id="distance" value="Abstand" v-model="violation" class="hidden" required>
                        <label for="distance" class="h-40 text-center border-4 border-white rounded cursor-pointer distance hover:border-secondary">
                        <span class="text-xl">Abstand</span></label>

                        <input type="radio" name="order[violation]" id="alcohol" value="Alkohol" v-model="violation" class="hidden" required>
                        <label for="alcohol" class="h-40 text-center border-4 border-white rounded cursor-pointer alcohol hover:border-secondary">
                        <span class="text-xl">Alkohol</span></label>

                        <input type="radio" name="order[violation]" id="phone" value="Telefon" v-model="violation" class="hidden" required>
                        <label for="phone" class="h-40 text-center border-4 border-white rounded cursor-pointer phone hover:border-secondary">
                        <span class="text-xl">Telefon</span></label>

                        <input type="radio" name="order[violation]" id="parking" value="Parken" v-model="violation" class="hidden" required>
                        <label for="parking" class="h-40 text-center border-4 border-white rounded cursor-pointer parking hover:border-secondary">
                        <span class="text-xl">Parken</span></label>
                    </div>
                </fieldset>
            </div>   

            <div :class="{'hidden':(activeTab !== 1)}" class="tab insurance-tab">
                <fieldset>
                    <legend class="mb-6">Hast Du eine Rechtschutzversicherung, die den Bereich Verkehr abdeckt?</legend>

                    <label class="block" for="insured">
                        <input @click="toggleInsuranceInfo" type="radio" name="order[insured]" id="insured" value="Ja" v-model="insurance" required>
                        <span class="p-2 align-middle">Ja</span>
                    </label>

                    <div class="relative ml-2 panel" id="insured-yes">
                        <input
                            class="block w-full mt-8 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                            type="text" name="order[insurance_company]" id="insuranceCompany"
                            placeholder="Name der Rechtschutz-Versicherung">
                        <label class="absolute mt-8" for="insuranceCompany">Name der Rechtschutz-Versicherung (optional)</label>
                    </div>
                    
                    <label class="block" for="not-insured">
                        <input @click="toggleInsuranceInfo" type="radio" name="order[insured]" id="not-insured" value="Nein" v-model="insurance" required>
                        <span class="p-2 align-middle">Nein</span>
                    </label>

                    <div class="ml-2 panel" id="insured-no">
                        <p>Du hast keine Rechtsschutzversicherung? <a class="text-secondary" href="https://www.arag-partner.de/jap_neu/fp/controller?channel=CHANNEL_INTERNET&action=external&productId=100&objectType=OBJECTTYPE_ANTRAG&activityId=%2FANT_NEU_VERK_SOFORT_INTERNET&eTrackerVerificationCode=thx9j9&kvgesellschaft=01&kooporga=255&koopvp=16347&kooppruefziffer=3&koopberechtigungpruefen=0&vertriebskanal=1&relaunch=true&utm_source=bussgelpruefer_com&utm_medium=link&utm_campaign=affiliates-VerSo" target="_blank">Hier</a> kannst Du über einen externen Versicherungsvermittler rückwirkend eine Versicherung für Deine Sache abschließen. Damit vertreten wir Dich vor der Behörde und soweit notwendig auch vor Gericht ohne weitere Kosten. <a class="text-secondary" href="#" @click.prevent="openLegalInfoModal"><i class="fas fa-info-circle"></i></a></p>
                    </div>
                </fieldset>
            </div>

            <div :class="{'hidden':(activeTab !== 2)}" class="tab">
                <fieldset>
                    <legend class="mb-6">Welches behördliche Schreiben hast Du zuletzt erhalten?</legend>
                    <label for="urgency1" class="block mb-3">
                        <input type="radio" name="order[urgency]" id="urgency1" value="1" v-model="urgency">
                    Zeugenfragebogen</label>
                    
                    <label for="urgency2" class="block mb-3">
                        <input type="radio" name="order[urgency]" id="urgency2" value="2" v-model="urgency">
                    Anhörungsbogen</label>

                    <label for="urgency3" class="block mb-3">
                        <input type="radio" name="order[urgency]" id="urgency3" value="3" v-model="urgency">
                    Bußgeldbescheid</label>

                    <label for="urgency4" class="block">
                        <input type="radio" name="order[urgency]" id="urgency4" value="4" v-model="urgency">
                    Keines / Unklar</label>
                </fieldset>
            </div>

            <div :class="{'hidden':(activeTab !== 3)}" class="tab address-tab">
                <fieldset>
                    <legend>Anschrift</legend>

                    <div class="mt-2">
                        <label class="inline-block mr-3">
                            <input type="radio" name="order[salutation]" value="Herr" v-model="salutation" required>
                            <span class="pl-1">Herr</span>
                        </label>
                        <label class="inline-block mr-3">
                            <input type="radio" name="order[salutation]" value="Frau" v-model="salutation" required>
                            <span class="pl-1">Frau</span>
                        </label>
                        <label class="inline-block">
                            <input type="radio" name="order[salutation]" value="Keine Angabe" v-model="salutation" required>
                            <span class="pl-1">Keine Angabe</span>
                        </label>
                    </div>
                    
                    <div class="grid gap-2 mt-4 sm:grid-cols-1 md:grid-cols-2">
                        <div class="relative w-full">
                            <input
                                class="block w-full mt-4 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                                type="text" name="order[firstname]" id="firstname"
                                placeholder="Vorname" v-model="firstName" required>
                            <label class="absolute pointer-events-none" for="firstname">Vorname</label>
                        </div>
                        <div class="relative w-full">
                            <input
                                class="block w-full mt-4 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                                type="text" name="order[lastname]" id="lastname"
                                placeholder="Nachname" v-model="lastName" required>
                            <label class="absolute pointer-events-none" for="lastname">Nachname</label>
                        </div>
                        <div class="relative w-full">
                            <input
                                class="block w-full mt-4 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                                type="text" name="order[address]" id="address"
                                placeholder="Straße und Hausnummer" v-model="address" required>
                            <label class="absolute pointer-events-none" for="address">Straße und Hausnummer</label>
                        </div>
                        <div class="relative w-full">
                            <input
                                class="block w-full mt-4 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                                type="number" name="order[postcode]" id="postcode" maxlenght="5" minlength="4"
                                placeholder="PLZ" v-model="postCode" required>
                            <label class="absolute pointer-events-none" for="postcode">PLZ</label>
                        </div>
                        <div class="relative w-full">
                            <input
                                class="block w-full mt-4 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                                type="text" name="order[city]" id="city"
                                placeholder="Ort" v-model="city" required>
                            <label class="absolute pointer-events-none" for="city">Ort</label>
                        </div>
                    </div>
                </fieldset>

                <fieldset class="mt-4">
                    <legend>Kontakt</legend>

                    <div class="grid gap-2 mt-4 sm:grid-cols-1 md:grid-cols-2">
                        <div class="relative w-full">
                            <input
                                class="block w-full mt-4 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                                type="text" name="order[phone]" id="phone"
                                placeholder="Telefon" v-model="phone" required>
                            <label class="absolute pointer-events-none" for="phone">Telefon</label>
                        </div>
                        <div class="relative w-full">
                            <input
                                class="block w-full mt-4 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                                type="text" name="order[email]" id="email"
                                placeholder="E-Mail" v-model="email" required>
                            <label class="absolute pointer-events-none" for="email">E-Mail</label>
                        </div>
                    </div>
                </fieldset>
            </div>

            <div :class="{'hidden':(activeTab !== 4)}" class="tab">
                <label for="document" class="block mb-6 text-xl">Dokumente Hochladen</label>
                <div id="files" class="flex flex-wrap gap-8">
                    <FilePicker name="files[]" />
                    <FilePicker name="files[]" />
                    <FilePicker name="files[]" />
                    <FilePicker name="files[]" />
                </div>
            </div>

            <div :class="{'hidden':(activeTab !== 5)}" class="text-center tab">
                <label for="terms" class="block mb-3">
                    <input type="checkbox" class="m-3" name="terms" id="terms" v-model="terms">
                    <span>Ich akzeptiere die <a href="/agb/" target="_blank" class="text-secondary">AGB</a> und die <a href="/datenschutz/" target="_blank" class="text-secondary">Hinweise zur Datenverarbeitung</a>.</span>
                </label>
                <label for="confidentiality" class="block mb-3">
                    <input type="checkbox" class="m-3" name="confidentiality" id="confidentiality" v-model="confidentiality">
                    <span>Ich akzeptiere die Befreiung von der Schweigepflicht</span>
                </label>

                <p>Hinweis: Für die Kommunikation zwischen BussgeldPrüfer (GDF GmbH) und der beauftragten Anwaltskanzlei ist die Entbindung von der Schweigepflicht dringend erforderlich. <a href="/entbindung-von-der-schweigepflicht/" target="_blank" class="text-secondary">Hier einsehen</a></p>
            </div>

            <!-- <div :class="{'hidden':(activeTab !== 5)}" class="text-center tab">
                <p class="mb-6">Um Deinen Bußgeldbescheid prüfen zu lassen <router-link class="underline" to="/login">melde dich an</router-link>. Oder erstelle einen <router-link class="underline" to="/registrieren">Account</router-link>.</p>
                <p>
                    <a href="#" @click.prevent="submitOrder()" class="text-secondary">submitOrder()</a>
                </p>
            </div> -->

            <div class="flex items-center justify-center mt-6 controls">
                <button v-if="(activeTab >= 1)" @click.prevent="decrement()" class="mr-4 btn-secondary">Zurück</button>
                <button v-if="(activeTab <= maxSteps - 2)" @click.prevent="stepNext()" class="mr-4 btn-secondary">Weiter</button>
                <button v-if="(activeTab == (maxSteps - 1))" @click.prevent="submitOrder()" class="mr-4 btn-secondary">Abschließen</button>
                <button @click.prevent="requestReset()" class="block btn-secondary">
                    <svg role="img" aria-labelledby="resetForm" class="w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <title id="resetForm">Neu starten</title>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                    </svg>
                </button>
            </div>

            <div class="mt-8 text-center">
                <LoadingCircle v-if="showLoadingCircle" />
            </div>

            <input type="hidden" name="order[p_id]" :value="publisherId">
        </form>

    </div>
</template>


<script>
import global from '../global';
import OrderProgress from '../components/OrderProgress.vue'
import Modal from '../components/BasicModal.vue'
import FilePicker from '../components/FilePicker.vue'
import LoadingCircle from '../components/BasicLoadingCircle.vue'

import { ref } from 'vue'
// import { useRouter, useRoute } from 'vue-router'

export default {
    components: {
        OrderProgress,
        Modal,
        FilePicker,
        LoadingCircle
    },

    data() {
        return {
            submitIssueModalTitle: 'Fehler',
            showLoadingCircle: false,
            publisherId: ''
        }
    },

    mounted() {
        this.publisherId = this.$route.query.p_id ?? '';
    },

    setup () {
        // max number of steps
        const maxSteps = 6 // 7
        // hide all .tab visually.
        // change this with class when activeTab = specific number
        const activeTab = ref(0) // 0
        //console.log(activeTab.value)
        const progressPercentage = ref(100 / maxSteps)

        // form data:
        const violation = ref('')
        const insurance = ref('')
        const urgency = ref('')
        const salutation = ref('')
        const firstName = ref('')
        const lastName = ref('')
        const address = ref('')
        const postCode = ref('')
        const city = ref('')
        const phone = ref('')
        const email = ref('')
        const terms = ref('')
        const confidentiality = ref('')

        // router
        // const router = useRouter()
        // const route = useRoute()

        /**
         * @param {number} tabNumber
         */
        function setActiveTab( tabNumber ) {
            activeTab.value = tabNumber;
        }

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

            violation.value = ''
            insurance.value = ''
            urgency.value = ''
            salutation.value = ''
            firstName.value = ''
            lastName.value = ''
            address.value = ''
            postCode.value = ''
            city.value = ''
            phone.value = ''
            email.value = ''
            terms.value = ''
            confidentiality.value = ''

            orderForm.reset()
        }

        function requestReset() {
            Modal.methods.fadeIn('resetFormModal');
        }

        function stepNext() {
            if (checkRequired())
                increment();
        }

        let missingRequiredModalTitle = ref('');
        let missingRequiredModalText = ref('');

        /**
         * @param {int} currentStep (optional)
         */
        function checkRequired( currentStep = activeTab.value + 1 ) {
            let missingItems = [];

            function checkVal( obj ) {
                return (!!obj.value);
            }

            switch (currentStep) {
                case 1:
                    if (!checkVal(violation))
                        missingItems.push('Verstoß');
                    break;

                case 2:
                    if (!checkVal(insurance))
                        missingItems.push('Rechtschutzversicherung');
                    break;

                case 3:
                    if (!checkVal(urgency))
                        missingItems.push('behördliches Schreiben');
                    break;

                case 4:
                    if (!checkVal(salutation))
                        missingItems.push('Anrede');
                    if (!checkVal(firstName))
                        missingItems.push('Vorname');
                    if (!checkVal(lastName))
                        missingItems.push('Nachname');
                    if (!checkVal(address))
                        missingItems.push('Straße und Hausnummer');
                    if (!checkVal(postCode))
                        missingItems.push('PLZ');
                    if (!checkVal(city))
                        missingItems.push('Ort');
                    if (!checkVal(phone))
                        missingItems.push('Telefon');
                    if (!checkVal(email))
                        missingItems.push('E-Mail');
                    break;

                // step 5 is optional (files)

                case 6:
                    if (!checkVal(terms))
                        missingItems.push('AGB und Hinweise zur Datenverarbeitung');
                    if (!checkVal(confidentiality))
                        missingItems.push('Befreiung von der Schweigepflicht');
                    break;
            }

            if (missingItems.length === 0)
                return true;

            missingRequiredModalTitle.value = 'Folgende Angabe fehlt noch:';
            if (missingItems.length > 1)
                missingRequiredModalTitle.value = 'Folgende Angaben fehlen noch:';

            missingRequiredModalText.value = '';
            missingItems.forEach(missingItem => {
                missingRequiredModalText.value += `- ${missingItem}<br>`;
            });

            // show modal
            Modal.methods.fadeIn('missingRequiredModal');

            return false;
        }

        function openLegalInfoModal() {
            Modal.methods.fadeIn('legalInfoModal');
        }

        return {
            activeTab,
            maxSteps,
            progressPercentage,
            // progressText,
            increment,
            decrement,
            reset,
            missingRequiredModalTitle,
            missingRequiredModalText,
            requestReset,
            stepNext,
            checkRequired,
            // submitOrder,
            openLegalInfoModal,
            violation,
            insurance,
            urgency,
            salutation,
            firstName,
            lastName,
            address,
            postCode,
            city,
            phone,
            email,
            terms,
            confidentiality
        }
    },
    methods: {
        modalResult: function(confirmation) {
            if (confirmation) this.reset();
        },
        toggleInsuranceInfo: function(event) {
            let panelYes = document.querySelector('#insured-yes');
            let panelNo = document.querySelector('#insured-no');
            let targetID = event.target.id;

            if (!panelYes || !panelNo) return;

            const hidePanel = panel => panel.style.maxHeight = null;
            const showPanel = panel => panel.style.maxHeight = panel.scrollHeight + 'px';

            if (targetID == 'insured') {
                showPanel(panelYes);
                hidePanel(panelNo);
            } else {
                hidePanel(panelYes);
                showPanel(panelNo);
            }
        },

        submitOrder() {
            if (!this.checkRequired()) return;

            this.$router.push({
                name: 'order-thank-you',
                query: {
                    order_number: '20210003-4269',
                    p_id: '4269'
                }
            });

            // show loading circle
            this.showLoadingCircle = true;

            let apiKey = '69890b3c0363ec96b7a61dc3be84f3ae55d960bce0d393cb661faaa5ff8dc1bb';
            let url = global.api.bgp + '/order-form/api.php?submit_form';
            // let url = 'http://localhost:4000/api.php?submit_form';
            // let url = 'http://localhost:4000/api.php?demo';
            let form = orderForm;
            let formData = new FormData(form);
            let xhr = new XMLHttpRequest();

            formData.append('api_key', apiKey);

            xhr.open('POST', url, true);
            xhr.onreadystatechange = () => {
                if (xhr.readyState === 4) {
                    // hide loading circle
                    this.showLoadingCircle = false;

                    if (xhr.status === 200) {
                        console.log(xhr); // TODO: remove this line

                        let response = JSON.parse(xhr.responseText);

                        if (response.error === false)
                            // redirect to the thank you page
                            this.$router.push({
                                name: 'order-thank-you',
                                query: {
                                    order_number: response.order_number,
                                    p_id: response.publisher_id
                                }
                            });
                    } else {
                        this.submitIssueModalTitle = 'Fehler (Code ' + xhr.status + ')';
                        Modal.methods.fadeIn('submitIssueModal');
                    }
                }
            };
            xhr.send(formData);
        }
    }
}
</script>


<style lang="scss" scoped>
.panel {
    padding: 0 18px;
    background-color: white;
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.2s ease-out;
}

input {
    &::-webkit-outer-spin-button,
    &::-webkit-inner-spin-button {
        -webkit-appearance: none;
    }

    &[type='number'] {
        -moz-appearance: textfield;
    }
}

// floating labels
input[type='text'] + label,
input[type='number'] + label {
    top: 0.6rem;
    left: 1rem; // change left
    transition: all 0.3s ease;
}

.insurance-tab {
    input[type='text'] + label {
        left: 2rem;
    }

    input[type='text']:focus + label,
    input[type='text']:not(:placeholder-shown) + label {
        left: 1.2rem;
    }
}

.address-tab {
    input[type='text'] + label,
    input[type='number'] + label {
        top: 1.6rem;
    }

    input[type='text']:focus + label,
    input[type='number']:focus + label,
    input[type='text']:not(:placeholder-shown) + label,
    input[type='number']:not(:placeholder-shown) + label {
        top: -0.6rem;
    }
}

input[type='text']::placeholder,
input[type='number']::placeholder {
    opacity: 0; 
}

input[type='text']:focus + label,
input[type='number']:focus + label,
input[type='text']:not(:placeholder-shown) + label,
input[type='number']:not(:placeholder-shown) + label {
    top: -1.6rem;
    left: 0; // 1rem
    font-size: 0.8em;
}

input[type='radio'] + label {
    font-size: 1rem;
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
    display: inline-grid;
    place-items: center;

    &::after {
        position: absolute;
        content: '';
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: #001329;
        opacity: 0.5;
    }

    span {
        z-index: 1;
        position: relative;
    }
}

input[type='radio']:checked + label {
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