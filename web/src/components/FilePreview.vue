<template>
    <div class="flex items-center overflow-hidden border-2 border-black rounded file-preview w-52 h-52">
        <img :src="src" class="block">
    </div>
</template>


<script>
export default {
    name: 'FilePrview',
    props: {
        src: String,
    },
}
</script>


<style lang="scss" scoped>
.file-preview {
    position: relative;
    background-image: url('../assets/img/add.png');
    background-position: center;
    background-size: 8rem;
    background-repeat: no-repeat;
    cursor: pointer;

    display: inline-flex;
    align-items: center;
    overflow: hidden;

    img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
}
</style>