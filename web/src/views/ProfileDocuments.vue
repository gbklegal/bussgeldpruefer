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

        <div v-if="addDocument">
            <p></p>
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
export default {
    data: () => {
        return {
            addDocument: false,
        }
    }
}
</script>
