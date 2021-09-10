<template>
    <div class="container catalog">
        <h1>Bußgeldkatalog</h1>
        <Search />
        <div class="flex flex-col md:flex-row mt-5">
            <!-- List of all Catalog Posts -->
            <nav class="bg-gray-200 rounded-sm md:w-1/3 mb-8 md:mb-0 md:mr-8 p-3" aria-label="In Page Navigation">
                <ul class="break-words" v-for="doc in docs" :key="doc.id">
                    <li class="block my-2">
                        <router-link :to="{ name: 'catalog-single', params: { docSlug: doc.slug } }" v-html="doc.title"></router-link>
                    </li>
                    <!-- <li class="block my-2"><router-link :to="{ name: 'catalog-alcohol' }">Alkohol</router-link></li>
                    <li class="block my-2"><router-link :to="{ name: 'catalog-else'}">Abstand</router-link></li>
                    <li class="block my-2"><router-link :to="{ name: 'catalog-else'}">Geblitzt</router-link></li>
                    <li class="block my-2"><router-link :to="{ name: 'catalog-else'}">Geschwindigkeitsüberschreitung</router-link></li> -->
                </ul>
            </nav>
            <!-- Catalog Post -->
            <div class="md:w-2/3 mb-8 md:mb-0 md:mr-8">
                <LoadingCircle v-if="!hideLoadingCircle" />
                <router-view :key="$route.fullPath" />
            </div>
        </div>
    </div>
</template>
<script>
import global from '../global';
import Search from '../components/BasicSearchForm.vue';
import LoadingCircle from '../components/BasicLoadingCircle.vue';

export default {
    components: {
        Search,
        LoadingCircle
    },

    data() {
        return {
            apiURL: global.api.base,
            docs: [],
            hideLoadingCircle: false
        }
    },

    methods: {
        fetchDocsData: function() {
            // display loading circle
            this.hideLoadingCircle = false;

            // let apiURL = this.apiURL + '/docs';
            let apiURL = 'http://bussgeldpruefer.local/backend/wp-json/wp/v2/docs?per_page=100';
            console.log(apiURL);
            fetch(apiURL).then(resp => resp.json()).then(docsData => {
                docsData.forEach(docData => {
                    let filteredData = {
                        id: docData.id,
                        slug: docData.slug,
                        title: docData.title.rendered
                    };

                    this.docs.push(filteredData);
                });
            });

            // hide loading circle
            this.hideLoadingCircle = true;
        }
    },

    beforeMount() {
        this.fetchDocsData();
    }
}
</script>