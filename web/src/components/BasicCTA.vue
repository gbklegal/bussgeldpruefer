<template>
    <section class="bg-primary">
        <div class="container text-center text-white font-light">
            <h2 class="mb-10 font-normal text-secondary">{{ title }}</h2>
            <p class="mb-10">{{ subtitle }}</p>
            <router-link class="btn-primary text-white font-normal" to="/bussgeldbescheid-pruefen">
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
    }
}
</script>