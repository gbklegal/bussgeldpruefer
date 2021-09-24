<template>
    <h1>DEV</h1>
    <Modal
        title="Hello World"
        text="Demo Text. Nice."
        button="OK"
        cancel="no"
        mode="info"
        :callback="result"
    />
    <button @click.prevent="showModal">open modal</button>
</template>

<script>
import Modal from '../components/BasicModal.vue';

export default {
    components: {
        Modal,
    },
    methods: {
        result: function(confirmation) {
            console.log(confirmation);
        },
        showModal: function() {
            Modal.methods.fadeIn();
        }
    }
}
</script>