<template>
    <div class="container">
        <h1 class="text-secondary">FAQ - Häufig gestellt Fragen</h1>
        <p class="text-xl">Themenübersicht</p>
        <Search />
        <div>
        </div>
    </div>
</template>
<script>
import Search from '../components/BasicSearchForm.vue'

export default {
    components: {
        Search,
    }
}
</script>