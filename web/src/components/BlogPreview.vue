<template>
    <div class="flex flex-col sm:flex-row text-left">
        <img :src="imgsrc" :alt="imgalt" class="rounded-sm object-cover h-44 w-full">
        <div class="ml-6">
            <h3>{{ blogtitle }}</h3>
            <p>{{ previewtext }}</p>
        </div>
    </div>
</template>
<script>
export default {
    name: 'BlogPreview',
    props: {
        blogtitle: String,
        previewtext: String,
        imgsrc: String,
        imgalt: String,
    }
}
</script>
