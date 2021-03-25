<template>
    <!-- TODO: Logic, firebase -->
    <div class="container">
        <h1>Kontakt</h1>
        <section>
            <h2>Du hast Fragen?</h2>
            <p class="mb-5">Falls noch offene Fragen bestehen, kannst du uns gerne kontaktieren.</p>

            <form id="contactform" action="">
                <fieldset class="mb-4">
                    <legend class="font-medium">Deine Kontaktdaten</legend>

                    <div class="relative">
                    <input 
                        class="mt-8 block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                        type="text" name="firstname" id="firstname" required
                        placeholder="Vorname">
                    <label class="absolute" for="firstname">Vorname</label>
                    </div>
 

                    <div class="relative">
                    <input 
                        class="mt-8 block mb-5 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                        type="text" name="lastname" id="lastname" required
                        placeholder="Nachname">
                        <label class="absolute" for="lastname">Nachname</label>
                    </div>


                    <div class="relative">
                    <input 
                        class="mt-8 block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                        type="email" name="email" id="email" required
                        placeholder="EMail">
                    <label class="absolute" for="email">E-Mail Adresse</label>
                    </div>


                    <div class="relative">
                    <input 
                        class="mt-8 block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                        type="tel" name="phone" id="phone"
                        placeholder="Telefonnummer">
                    <label class="absolute" for="phone">Telefonnummer</label>
                    </div>

                </fieldset>

                <label class="block font-medium mb-6 mt-5" for="message">Deine Nachricht</label>
                <textarea 
                    class="block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" 
                    name="message" id="message" cols="30" rows="10" required></textarea>

                <button
                    class="btn-primary focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50"
                    type="submit">Senden</button>
            </form>
        </section>

        <section class="mt-8">
            <h2>Du kannst uns auch direkt erreichen</h2>
            <div>
                <span class="mr-2">Email:</span>
                <a href="mailto:dialog@bussgeldpruefer.de">dialog@bussgeldpruefer.de</a>
            </div>
            <div>
                <span class="mr-2">Tel:</span>
                <a href="tel:091112345678">0911/12345678</a>
            </div>
        </section>
    </div>
</template>

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
</style>