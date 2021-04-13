<template>
    <section class="bg-primary">
        <div class="container text-center text-white font-light">
            <span class="inline-block mb-4 text-sm">{{ smallText }}</span>
            <h2 class="mb-6 font-normal text-secondary">{{ title }}</h2>
            <p class="mb-10">{{ subtitle }}</p>
            <router-link class="btn-primary text-white font-normal" :to="{ name: 'order' }">
                Bussgeldbescheid Prüfung
            </router-link>
        </div>
    </section>
</template>
<script>
export default {
    name: 'CTA',
    props: {
        title: String,
        subtitle: String,
        smallText: String,
    }
}
</script>