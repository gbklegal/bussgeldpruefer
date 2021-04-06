<template>
    <h2 class="text-xl">E-Mail schreiben</h2>

    <form @submit.prevent>
        <div class="form-item items-center grid border-2 border-gray-200 rounded-sm">
            <label class="mx-2" for="sendTo">An:</label>
            <input v-model="mailTo" class="border-transparent border-2 rounded focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" type="text" name="sendTo" id="sendTo">
        </div>
        <div class="form-item items-center grid border-2 border-t-0 border-gray-200 rounded-sm">
            <label class="mx-2" for="sendFrom">Von:</label>
            <input v-model="mailFrom" class="border-transparent border-2 rounded focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" type="text" name="sendFrom" id="sendFrom">
        </div>
        <div class="form-item items-center grid border-2 border-t-0 border-gray-200 rounded-sm">
            <label class="mx-2" for="subject">Betreff:</label>
            <input v-model="mailSubject" class="border-transparent border-2 rounded focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" type="text" name="subject" id="subject">
        </div>
        <div class="border-2 border-t-0 border-gray-200 rounded-sm">
            <textarea v-model="mailBody" class="w-full border-transparent border-2 rounded focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50" name="sendText" id="sendText" cols="30" rows="10"></textarea>
        </div>
        <button class="btn-primary mt-4" type="submit">senden</button>
    </form>

    <!-- debuggeing <p>An: {{mailTo}}</p>
    <p>Von: {{mailFrom}}</p>
    <p>Betreff: {{mailSubject}}</p>
    <p>Body: {{mailBody}}</p> -->

</template>

<script>
import { ref } from 'vue'

export default {
    setup() {
        // form data
        const mailTo = ref('')
        const mailFrom = ref('')
        const mailSubject = ref('')
        const mailBody = ref('')
    },
}
</script>

<style scoped>
    .form-item {
        grid-template-columns: auto 1fr;
    }
</style>