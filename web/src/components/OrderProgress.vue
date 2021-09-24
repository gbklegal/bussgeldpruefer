<template>
    <label class="text-xs block text-right" for="order-progress">Schritt {{ currentNumber }} von {{ maxNumber }}</label>
    <!-- <progress id="order-progress" :value="percentage" max="100" class="bg-gray-200 block w-full rounded">{{ percentage }}%</progress> -->
    <div class="progress-wrapper bg-gray-200 block w-full rounded">
        <div class="progress bg-gray-200 block rounded" :style="'width:'+percentage+'%'" id="progressBar">&nbsp;</div>
    </div>
</template>
<script>
export default {
    props: {
        currentNumber: Number,
        maxNumber: Number,
        percentage: Number,
    }
}
</script>
<style scoped>
/* Reset default */
progress[value],
.progress-wrapper {
    -webkit-appearance: none;
       -moz-appearance: none;
            appearance: none;
    border: none;
    color: #5CC8C5;
}

.progress-wrapper,
.progress {
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.25) inset;
}

progress[value]::-webkit-progress-bar,
.progress {
    /*background-color: #eee;*/
    background-color: #fff;
    border-radius: 3px;
}

progress[value]::-moz-progress-bar,
.progress {
    background-color: #5CC8C5;
    border-radius: 3px;
}

progress[value]::-webkit-progress-value,
.progress {
    background-color: #5CC8C5;
    border-radius: 3px;
    transition: width .5s ease;
}
</style>
