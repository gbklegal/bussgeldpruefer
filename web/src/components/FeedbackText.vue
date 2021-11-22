<template>
    <div class="mt-5 text-justify">
        <p class="inline ">&#8222;{{ quote }}&#8220;</p>
        <p class="inline mx-2">&#8722;</p>
        <p class="text-sm inline">{{ author }}</p>
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