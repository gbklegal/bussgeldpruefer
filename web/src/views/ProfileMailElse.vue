<template>
    <h2 class="text-xl inline">Sonstiges</h2>
    
    <div class="bg-secondary rounded-full text-white h-6 w-6 text-center inline-block ml-4">
        <span class="leading-6 inline-block">1</span>
    </div>

    <!-- Message -->
    <div class="py-5 border-b-2 border-gray-200 flex justify-between">
        <div class="font-light">
            <p>Diese Unterlagen fehlen</p>
            <p>Sehr geehrte Herr Xy, vielen Dank für Interesse. Bla</p>
        </div>
        <div>
            <span>23.12.</span>
            <button @click="marked = !marked" class="block mx-auto">
                <img v-if="!marked" class="w-5" src="/src/assets/img/star-outline.svg" alt="Klicke hier um die Nachricht zu markieren.">
                <img v-if="marked" class="w-5" src="/src/assets/img/star.svg" alt="Klicke hier um die Nachricht nicht mehr zu markieren.">
            </button>

        </div>
    </div>
</template>
<script>
export default {
    data: () => {
        return {
            marked: false,
        }
    }
}
</script>