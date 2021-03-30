<template>
    <div class="relative">
        <div class="bg-gray-200 block sm:w-full sm:h-24 rounded shadow-inner h-96 w-24">
            <div class="sm:w-1/4 h-1/4 w-24 sm:h-24 bg-secondary rounded"></div>
        </div>

        <div class="absolute w-full h-96 sm:h-auto grid sm:grid-cols-4 -top-1 left-1.5 sm:left-0">
            <div class="text-center flex sm:flex-col">
                <img class="w-20 block sm:mx-auto mt-3" src="/src/assets/img/assignment.svg" alt="Icon mit Dokumenten.">
                <span class="inline-block mt-3 ml-5 sm:ml-0 text-sm">Antrag abgeben</span>
            </div>
            <div class="text-center flex sm:flex-col">
                <img class="w-20 block sm:mx-auto mt-3" src="/src/assets/img/communication.svg" alt="Icon mit Personen.">
                <span class="inline-block mt-3 ml-5 sm:ml-0 text-sm">Fallbesprechung</span>
            </div>
            <div class="text-center flex sm:flex-col">
                <img class="w-20 block sm:mx-auto mt-3" src="/src/assets/img/innovation.svg" alt="Icon mit Lupe.">
                <span class="inline-block mt-3 ml-5 sm:ml-0 text-sm">Überprüfung</span>
            </div>
            <div class="text-center flex sm:flex-col">
                <img class="w-20 block sm:mx-auto mt-3" src="/src/assets/img/sentence.svg" alt="Icon mit Richterhammer">
                <span class="inline-block mt-3 ml-5 sm:ml-0 text-sm">Urteil</span>
            </div>
        </div>
    </div>

</template>
<script>
export default {
    props: {
        percentage: Number,
    }
}
</script>
<style scoped>

span {
    line-height: 5rem;
}

@media (min-width: 640px) {
    span {
        line-height: 1.25rem;
    }
}

</style>
