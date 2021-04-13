<template>
    <transition name="slide-fade">
        <div v-if="!hideBadge" @click="hideBadge = !hideBadge" class="ease-in-out transition-all duration-500 badge-container fixed bg-transparent w-full">
        <div class="badge shadow cursor-pointer bg-secondary  place-content-center gap-2 grid">
            <img class="w-28 m-2 rounded shadow" src="../assets/img/bgpapp-qrcode.png" alt="Hol dir die BussgeldPrüfer App via QR Code.">
            <p class="my-auto text-white">Lade die App für den <br>Quick-Check</p>
        </div>
        </div>
    </transition>
</template>

<script>
export default {
   name: 'Badge',
   data: () => {
        return {
            hideBadge: false,
        }
    }
}
</script>

<style scoped>
.badge-container {
    bottom: 300px;
    opacity: 1;
    z-index: 999;
}

.badge {
    grid-template-columns: auto 1fr;
    --width: 250px;
    --height: 130px;
    width: var(--width);
    height: var(--height);
    --color: #5DC8C5;
}

.badge:after {
    position: absolute;
    content: " ";
    border-style: solid;
    border-width: calc(var(--height)/2) 1em;
    border-color: var(--color) transparent var(--color) var(--color);
    left: calc(var(--width) - 10px);
}

.slide-fade-enter-active, .slide-fade-leave-active {
  transition: opacity 0.25s ease-out;
}

.slide-fade-enter, .slide-fade-leave-to {
  opacity: 0;
}
</style>