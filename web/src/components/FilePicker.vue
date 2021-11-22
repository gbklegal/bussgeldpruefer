<template>
    <label>
        <input type="file" :name="name" :accept="accept" @change="filePicker($event)">
        <FilePreview :src="imageSrc" />
    </label>
</template>

<script>
import FilePreview from './FilePreview.vue'

export default {
    components: {
        FilePreview
    },

    name: 'FilePicker',
    props: {
        name: String,
        accept: {
            default: 'image/png, image/jpeg, image/gif',
            type: String
        },
        filePreview: {
            default: true,
            type: Boolean
        }
    },

    data() {
        return {
            imageSrc: ''
        }
    },

    methods: {
        filePicker(event) {
            let file = event.target.files[0];
            let imageSrc = URL.createObjectURL(file);
            this.imageSrc = imageSrc;
        }
    }
}
</script>

<style lang="scss" scoped>
    input[type='file'] {
        display: none;
    }
</style>