<template>
    <h2 class="text-xl inline">Markiert</h2>

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
            marked: true,
        }
    }
}
</script>