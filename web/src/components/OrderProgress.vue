<template>
    <label class="text-xs float-right" for="order-progress">{{ text }}</label>
    <progress id="order-progress" :value="percentage" max="100" class="bg-gray-200 block w-full rounded">{{ percentage }}%</progress>
</template>
<script>
export default {
    props: {
        text: String,
        percentage: Number,
    }
}
</script>
<style scoped>
/* Reset default */
progress[value] {
    -webkit-appearance: none;
       -moz-appearance: none;
            appearance: none;
    border: none; 
    color: #5CC8C5;
}

progress[value]::-webkit-progress-bar {
    /*background-color: #eee;*/
    background-color: #fff;
    border-radius: 3px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.25) inset;
}

progress[value]::-moz-progress-bar {
    background-color: #5CC8C5;
    border-radius: 3px;
}

progress[value]::-webkit-progress-value {
    background-color: #5CC8C5;
    border-radius: 3px;
}
</style>
