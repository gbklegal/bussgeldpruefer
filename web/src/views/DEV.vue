<template>
    <div class="container">
        <input type="text" v-model="search" @keyup="getResults()">

        <ul v-if="results" :key="resultsKey">
            <li v-for="result in results" :key="result.id" v-html="result.title"></li>
        </ul>
    </div>
</template>


<script>
export default ({
    data() {
        return {
            results: [],
            resultsKey: 1,
            search: ''
        }
    },

    methods: {
        fetchDocsData: function(searchQuery) {
            this.resultsKey = Math.random();
            this.results = [];

            let apiURL = 'http://localhost:4000/wp-json/wp/v2/docs?per_page=100&order=asc&orderby=title'; // http://bussgeldpruefer.local/backend/
            if (searchQuery) {
                apiURL += '&search=' + searchQuery;
            }

            console.log('fetchDocsData', searchQuery, this.resultsKey, this.results, apiURL);

            fetch(apiURL).then(resp => resp.json()).then(docsData => {
                console.log(docsData);
                docsData.forEach(docData => {
                    let filteredData = {
                        id: docData.id,
                        slug: docData.slug,
                        title: docData.title.rendered
                    };

                    this.results.push(filteredData);
                });
            });
        },
        getResults: function() {
            if (this.search) this.fetchDocsData(this.search);
        }
    },
})
</script>
