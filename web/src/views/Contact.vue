<template>
    <Modal
        title="Fehler"
        text='Die Anfrage konnte leider nicht versendet werden. Bitte versuche es erneut oder schreibe uns einfach eine E-Mail an <a href="mailto:dialog@bussgeldpruefer.com" class="text-primary">dialog@bussgeldpruefer.com</a>.'
        :isHTML="true"
        button="OK"
        mode="error"
    />
    <div class="container">
        <h1>Kontakt</h1>
        <section>
            <h2>Du hast Fragen?</h2>
            <p class="mb-5">Falls noch offene Fragen bestehen, kannst Du uns gerne kontaktieren.</p>

            <form id="contactform" @submit.prevent="submitContactForm" class="max-w-lg">
                <fieldset class="mb-4">
                    <legend class="font-medium">Deine Kontaktdaten</legend>

                    <div class="relative w-full">
                        <input 
                            class="block w-full mt-8 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                            type="text" name="firstname" id="firstname" required
                            placeholder="Vorname" v-model="firstName">
                        <label class="absolute" for="firstname">Vorname</label>
                    </div>

                    <div class="relative w-full">
                        <input 
                            class="block w-full mt-8 mb-5 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                            type="text" name="lastname" id="lastname" required
                            placeholder="Nachname" v-model="lastName">
                        <label class="absolute" for="lastname">Nachname</label>
                    </div>

                    <div class="relative">
                        <input 
                            class="block w-full mt-8 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                            type="email" name="email" id="email"
                            placeholder="E-Mail" v-model="eMail">
                        <label class="absolute" for="email">E-Mail Adresse</label>
                    </div>


                    <div class="relative">
                        <input 
                            class="block w-full mt-8 mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                            type="tel" name="phone" id="phone"
                            placeholder="Telefonnummer" v-model="phone">
                        <label class="absolute" for="phone">Telefonnummer</label>
                    </div>

                </fieldset>

                <label class="block mt-5 mb-6 font-medium" for="message">Deine Nachricht</label>
                <textarea 
                    class="block w-full mb-3 border-2 rounded border-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                    name="message" id="message" cols="30" rows="10" required v-model="message"
                    placeholder="Inhalt Deiner Nachricht"
                    ></textarea>

                <fieldset class="mb-4">
                    <div class="mt-4 mb-3">
                        <input type="radio" name="contact-type" id="contact-type-phone" value="Telefon" @click="toggleRequiredContactType" v-model="contactType" required>
                        <label
                            class="pl-2 cursor-pointer"
                            for="contact-type-phone">Ich möchte <strong>telefonisch</strong> kontaktiert werden.</label>
                    </div>
                    <div class="mb-3">
                        <input type="radio" name="contact-type" id="contact-type-email" value="E-Mail" @click="toggleRequiredContactType" v-model="contactType" required>
                        <label
                            class="pl-2 cursor-pointer"
                            for="contact-type-email">Ich möchte <strong>per E-Mail</strong> kontaktiert werden.</label>
                    </div>
                </fieldset>

                <div>
                    <button
                        class="btn-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                        type="submit">Senden</button>
                    <LoadingCircle class="ml-2" />
                </div>
            </form>
        </section>

        <section class="mt-8">
            <h2>Du kannst uns gerne auch direkt per E-Mail erreichen:</h2>
            <div>
                <span class="mr-2">E-Mail:</span>
                <a href="mailto:dialog@bussgeldpruefer.com">dialog@bussgeldpruefer.com</a>
            </div>
            <!--
            <div>
                <span class="mr-2">Tel:</span>
                <a href="tel:091112345678">0911/12345678</a>
            </div>
            -->
        </section>
    </div>
</template>

<script>
import global from '../global'
import Modal from '../components/BasicModal.vue';
import LoadingCircle from '../components/BasicLoadingCircle.vue';
import { ref  } from 'vue'
import { useRouter, useRoute } from 'vue-router'

export default {
    components: {
        Modal,
        LoadingCircle
    },

    setup() {
        const firstName = ref('')
        const lastName = ref('')
        const eMail = ref('')
        const phone = ref('')
        const message = ref('')
        const contactType = ref('')

        // router
        const router = useRouter()

        function submitContactForm() {
            loadingCircle(true);
            const apiUrl = global.api.bgp + '/contactform/contactform.php';
            let xhr = new XMLHttpRequest();
            let formData = new FormData();

            // little helper function
            const checkVal = elmt => {
                if (elmt.value) {
                    return elmt.value;
                }
                return '/';
            }

            formData.append('firstname', checkVal(firstName));
            formData.append('lastname', checkVal(lastName));
            formData.append('email', checkVal(eMail));
            formData.append('phone', checkVal(phone));
            formData.append('message', checkVal(message));
            formData.append('contactType', checkVal(contactType));
            formData.append('source', 'Website');
            formData.append('mailTo', 'roeder@gbk-rae.de'); // only for development (TODO: remove in prod.)

            xhr.onreadystatechange = () => {
                if (xhr.readyState === 4) {
                    loadingCircle(false);
                    if (xhr.status === 200) {
                        let response = JSON.parse(xhr.responseText);
                        
                        if (response.sendmail) {
                            router.push({name: 'contact-thank-you'})
                        } else {
                            openContactFormModal();
                        }
                    } else {
                        openContactFormModal();
                    }
                }
            };
            xhr.open('POST', apiUrl, true);
            xhr.send(formData);
        }

        function toggleRequiredContactType(elmt) {
            const targetId = elmt.target.id;
            const phoneElmt = document.querySelector('#phone');
            const emailElmt = document.querySelector('#email');

            if (targetId === 'contact-type-phone') {
                phoneElmt.required = true;
                emailElmt.required = false;
            }
            else if (targetId === 'contact-type-email') {
                emailElmt.required = true;
                phoneElmt.required = false;
            }
        }

        function openContactFormModal() {
            Modal.methods.fadeIn();
        }

        function loadingCircle(isVisible) {
            const loadingCircleElmt = document.querySelector('.loading-circle');

            if (isVisible) {
                return loadingCircleElmt.style.visibility = 'visible';
            }
            return loadingCircleElmt.style.visibility = 'hidden';
        }

        return {
            firstName,
            lastName,
            eMail,
            phone,
            message,
            contactType,
            submitContactForm,
            toggleRequiredContactType,
            openContactFormModal,
            loadingCircle
        }
    }
}
</script>

<style lang="scss" scoped>
    .loading-circle {
        visibility: hidden;
    }

    // floating labels
    label {
        top: 0.6rem;
        left: 0.5rem;
        transition: all 0.3s ease;
    }

    input::placeholder {
        opacity: 0;
    }

    input:focus + label,
    input:not(:placeholder-shown) + label {
        top: -1.6rem;
        left: 0;
        font-size: 0.8em;
    }

    input[type='radio'] + label {
        font-size: 1rem;
    }
</style>