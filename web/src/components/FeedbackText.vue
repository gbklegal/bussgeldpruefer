<template>
    <div class="mt-5">
        <p class="inline">"{{ quote }}"</p>
        <p class="text-sm ml-4 inline">{{ author }}</p>
    </div>
</template>
<script>
export default {
    props: {
        quote: String,
        author: String,
    }
}
</script>