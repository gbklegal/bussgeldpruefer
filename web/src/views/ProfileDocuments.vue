<template>
    <div class="w-full">
        <h2 class="text-xl text-secondary">Was Du bis jetzt hochgeladen hast:</h2>
        <ul class="border-gray-200 border-b-2 mb-5">
            <!-- different lis or one list item with a 'flag' -->
            <li class="mb-2 flex justify-between">
                <div>
                    <span class="block text-secondary mb-3">Anhang 1</span>
                    <span class="inline-block bg-secondary rounded-sm text-white py-2 px-1">Verwarnung</span>
                </div>
                <img src="/src/assets/img/document.svg" alt="">
            </li>
        </ul>
        <button @click="addDocument = !addDocument" class="btn-secondary">weiteres Dokument hinzufügen</button>

        <div v-if="addDocument" class="border-gray-200 border-b-2 mb-5 mt-10">
            <form @submit.prevent>
                <label class="mb-3 block" for="documentType">1. Wähle ein Dokument aus, dass Du hochladen willst.</label>
                <select class="block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" v-model="docType" name="documentType" id="documentType">
                    <option value="Verwarnungsbogen">Verwarnungsbogen</option>
                    <option value="Bußgeldbescheid">Bußgeldbescheid</option>
                    <option value="Anhörungsbogen">Anhörungsbogen</option>
                    <option value="Sonstiges">Sonstiges</option>
                </select>
                
                <label for="document" class="mb-3 block">2. Mach ein Foto von deinem Dokument</label>
                <input class="block mb-3 rounded" type="file" name="document" id="document" multiple>

                <input type="submit" value="senden" class="btn-primary my-3" @click="addDocument = !addDocument">   
            </form>
            <!-- debugging <span>{{docType}}</span>-->
        </div>

        <p class="text-secondary mb-2 text-xl mt-10">Was wir von Dir mindestens  brauchen, um deinen Fall bearbeiten zu können:</p>
        <ul class="list-disc ml-4">
            <li>Verwarnungsbogen</li>
            <li>Bußgeldbescheid und/oder</li>
            <li>Anhörungsbogen</li>
        </ul>
    </div>
</template>

<script>
import { ref } from 'vue'

export default {
    setup() {
        const addDocument = ref(false)

        // form data
        const docType = ref('')

        return {
            addDocument,
            docType,
        }
    },
}
</script>
