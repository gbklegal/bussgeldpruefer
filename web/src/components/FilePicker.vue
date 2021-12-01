<template>
    <Modal
        :id="modalId"
        title="Bist Du sicher?"
        text="Bist sicher, dass Du dieses Dokument entfernen möchtest?"
        button="Ja"
        cancel="Abbrechen"
        mode="warning"
        :callback="modalCallback"
    />
    <div class="filepreview-wrapper">
        <label @drop.prevent="filePicker" @dragover.prevent>
            <input type="file" :name="name" :accept="accept" @change="filePicker">
            <FilePreview :src="imageSrc" />
        </label>
        <i v-if="showRemover" @click="requestReset" class="text-red-600 fas fa-minus-circle remove-file" title="Dokument entfernen"></i>
    </div>
</template>

<script>
import global from '../global'
import FilePreview from './FilePreview.vue'
import Modal from './BasicModal.vue'

export default {
    components: {
        FilePreview,
        Modal
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
            file: null,
            modalId: null,
            imageSrc: '',
            showRemover: false
        }
    },

    mounted() {
        this.modalId = global.makeId(5);
    },

    methods: {
        filePicker(event) {
            let file = null;
            if (event.type === 'change')
                file = event.target.files[0];
            else if (event.type === 'drop')
                file = event.dataTransfer.files[0];
            else
                return false;

            let imageSrc = URL.createObjectURL(file);
            this.imageSrc = imageSrc;
            this.file = event.target;
            this.showRemover = true;
        },
        requestReset() {
            Modal.methods.fadeIn(this.modalId);
        },
        modalCallback(modalResponse) {
            if (modalResponse === true) {
                this.imageSrc = null;
                this.file.value = '';
                this.showRemover = false;
            }
        }
    }
}
</script>

<style lang="scss" scoped>
    .filepreview-wrapper {
        position: relative;

        input[type='file'] {
            display: none;
        }

        i.remove-file {
            z-index: 1;
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 22px;
            cursor: pointer;
        }
    }
</style>