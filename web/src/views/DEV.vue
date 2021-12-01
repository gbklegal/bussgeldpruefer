<template>
    <div class="container">
        <h1>DEV</h1>
        Variable value: <span>{{ tmp }}</span>

        <div class="pt-4">
            <button class="btn-secondary" @click="orderThankYou">order thank you</button>
        </div>

    </div>
</template>

<script>
export default {
    data() {
        return {
            tmp: 'Hello World'
        }
    },

    methods: {
        orderThankYou() {
            this.$router.push({
                name: 'order-thank-you',
                query: {
                    order_number: '20210003-4231',
                    p_id: '4231'
                }
            });
        }
    }
}
</script>