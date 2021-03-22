<template>
    <section class="bg-primary">
        <div class="container text-center text-white">
            <h2 class="mb-10 text-2xl md:text-3xl text-secondary">{{ title }}</h2>
            <!-- TODO: only show p if prop is submitted -->
            <p class="mb-10">{{ subtitle }}</p>
            <router-link class="btn-primary text-white" to="/bussgeldbescheid-pruefen">
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