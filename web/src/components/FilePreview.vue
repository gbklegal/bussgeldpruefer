<template>
    <div class="file-preview w-52 h-52 border-2 border-black rounded flex items-center overflow-hidden">
        <img :src="src" class="block">
    </div>
</template>


<script>
export default {
    name: 'FilePrview',
    props: {
        src: String
    },
}
</script>


<style lang="scss" scoped>
    .file-preview {
        background-image: url('../assets/img/add.png');
        background-position: center;
        background-size: 8rem;
        background-repeat: no-repeat;
        cursor: pointer;
    }
</style>