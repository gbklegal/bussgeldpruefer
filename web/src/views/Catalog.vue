<template>
    <div class="container catalog">
        <h1>Bußgeldkatalog</h1>
        <Search />
        <div class="flex flex-col md:flex-row mt-5">
            <!-- List of all Catalog Posts -->
            <nav class="bg-gray-200 rounded-sm md:w-1/3 mb-8 md:mb-0 md:mr-8" aria-label="In Page Navigation">
                <ul class="break-words">
                    <li class="block my-2"><router-link :to="{ name: 'catalog-alcohol' }">Alkohol</router-link></li>
                    <li class="block my-2"><router-link :to="{ name: 'catalog-else'}">Geschwindigkeitsüberschreitung</router-link></li>
                    <li class="block my-2"><router-link :to="{ name: 'catalog-else'}">Geschwindigkeitsüberschreitung</router-link></li>
                    <li class="block my-2"><router-link :to="{ name: 'catalog-else'}">Geschwindigkeitsüberschreitung</router-link></li>
                </ul>
            </nav>
            <!-- Catalog Post -->
            <router-view />
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