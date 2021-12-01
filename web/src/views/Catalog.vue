<template>
    <div class="container catalog">
        <h1>Bußgeldkatalog</h1>

        <Search
            :oninput="fastSearch"
            :fastSearch="true"
        />

        <div class="flex flex-col mt-5 md:flex-row">
            <!-- List of all Catalog Posts -->
            <nav id="catalog-nav" class="p-3 mb-8 bg-gray-200 rounded-sm md:w-1/3 md:mb-0 md:mr-8" aria-label="In Page Navigation">
                <div v-if="!hideSkeleton">
                    <Skeleton v-for="i in 20" :key="i" type="navList" />
                </div>
                <ul class="break-words" v-for="doc in docs" :key="doc.id">
                    <li class="block my-2">
                        <router-link :to="{ name: 'catalog-single', params: { docSlug: doc.slug } }" v-html="doc.title"></router-link>
                    </li>
                </ul>
            </nav>
            <!-- Catalog Post -->
            <div class="mb-8 md:w-2/3 md:mb-0 md:mr-8" data-empty="Wählen Sie ein Thema auf der linken Seite aus." data-empty-sm="Wählen Sie ein Thema (oben) aus.">
                <router-view :key="$route.fullPath" />
            </div>
        </div>
    </div>
</template>


<script>
import global from '../global';
import Search from '../components/BasicSearchForm.vue';
import Skeleton from '../components/BasicSkeleton.vue';

export default {
    components: {
        Search,
        Skeleton
    },

    data() {
        return {
            apiURL: global.api.base,
            docs: [],
            hideSkeleton: false
        }
    },

    methods: {
        fetchDocsData: function(searchQuery) {
            // display loading skeleton
            this.hideSkeleton = false;

            let apiURL = this.apiURL + '/docs?per_page=100&order=asc&orderby=title&_fields=id,slug,title';

            if (searchQuery) {
                apiURL += '&search=' + searchQuery;
            }

            fetch(apiURL).then(resp => resp.json()).then(docsData => {
                docsData.forEach(docData => {
                    let filteredData = {
                        id: docData.id,
                        slug: docData.slug,
                        title: docData.title.rendered
                    };

                    this.docs.push(filteredData);
                });

                // hide loading skeleton
                this.hideSkeleton = true;
            });
        },
        fastSearch: function() {
            let elmt = document.querySelector('#fastSearchQuery');
            let query = elmt.value;
            let items = document.querySelectorAll('nav#catalog-nav ul li');
            let regEx = new RegExp(query, 'gi');

            items.forEach(item => {
                let itemVal = item.innerText;
                let matches = regEx.test(itemVal);
                
                if (matches) {
                    item.classList.remove('hidden');
                } else {
                    item.classList.add('hidden');
                }
            });

            // console.log(query);
        }
    },

    // computed: {
        
    // },

    beforeMount() {
        if (this.$route.query.search) {
            let searchQuery = this.$route.query.search;
            this.fetchDocsData(searchQuery);
            return;
        }

        this.fetchDocsData();
    },

    mounted() {
        window.scrollTo(0, 0);
    }
}
</script>


<style lang="scss" scoped>
@media (min-width: 767px) {
    [data-empty]:empty::before {
        content: attr(data-empty);
    }
}

@media (max-width: 767px) {
    [data-empty-sm]:empty::before {
        content: attr(data-empty-sm);
    }
}
</style>