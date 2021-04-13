<template>
    <!-- TODO: Logic, firebase -->
    <div class="container">
        <h1>Login</h1>
        <section>
            <p>Du hast noch keinen Account?</p>
            <router-link :to="{ name: 'signup' }" class="underline mt-3 font-medium">Hier registrieren!</router-link>

            <form id="contactform" @submit.prevent="redirect">

                <div class="relative">
                    <input 
                    class="mt-8 block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                    type="email" name="email" id="email" 
                    placeholder="EMail" v-model="eMail">
                    <label class="absolute" for="email">E-Mail Adresse</label>
                </div>

                <div class="relative password-input mt-12">
                    <!-- button to show / hide password -->
                    <button @click="togglePasswordVisibility" class="absolute">
                        <!-- icon if password is hidden -->
                        <svg v-if="hidden" class="w-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                          <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
                            <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" />
                        </svg>
                        <!-- icon if password is displayed -->
                        <svg v-if="!hidden" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M3.707 2.293a1 1 0 00-1.414 1.414l14 14a1 1 0 001.414-1.414l-1.473-1.473A10.014 10.014 0 0019.542 10C18.268 5.943 14.478 3 10 3a9.958 9.958 0 00-4.512 1.074l-1.78-1.781zm4.261 4.26l1.514 1.515a2.003 2.003 0 012.45 2.45l1.514 1.514a4 4 0 00-5.478-5.478z" clip-rule="evenodd" />
                            <path d="M12.454 16.697L9.75 13.992a4 4 0 01-3.742-3.741L2.335 6.578A9.98 9.98 0 00.458 10c1.274 4.057 5.065 7 9.542 7 .847 0 1.669-.105 2.454-.303z" />
                        </svg>
                    </button>
                    <div class="relative">
                        <input 
                        :type="fieldType"
                        class="mt-8 block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                        name="password" id="password"
                        placeholder="Passwort" v-model="password">
                        <label class="absolute" for="password">Passwort</label>   
                    </div>
                </div>
                
                <input 
                class="btn-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50 mt-6"
                type="submit" value="Login" />
            </form>
        </section>
    </div>
</template>

<script>
import { ref  } from 'vue'
import { useRouter, useRoute } from 'vue-router'

export default {
    setup() {
        // router
        const router = useRouter()

        // form data
        const eMail = ref('')
        const password = ref('')

        const hidden = ref(true)
        const fieldType = ref('password')

        function togglePasswordVisibility() {
            fieldType.value = fieldType.value === 'password' ? 'text' : 'password';
            hidden.value = !hidden.value;
        }

        function redirect() {
            router.push({name: 'profile-mail'})
        }

        return {
            eMail,
            password,
            hidden,
            fieldType,
            togglePasswordVisibility,
            redirect
        }
    }
}
</script>

<style lang="scss" scoped>
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

    // password input with show/hide-button
    .password-input button {
        top: -1.5rem;
        left: 12rem;
    }

</style>