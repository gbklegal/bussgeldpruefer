<template>
    <div v-for="doc in docs" :key="doc.id" class="doc">
        <h2 class="text-secondary" v-html="doc.title"></h2>
        <p v-html="doc.content"></p>
    </div>
</template>


<style>
.doc * {
    max-width: 100%;
}

.doc table {
    overflow: auto;
    display: block;
    margin-bottom: 1em;
}
.doc table th {
    text-align: inherit;
}
.doc table td,
.doc table th {
    border-width: 0 0 2px;
    /* border: 1px solid #dbdbdb; */
    padding: .5em .75em;
    vertical-align: top;
}

.doc hr {
    margin-top: 0.75em;
    margin-bottom: 0.75em;
}

.doc h1 {
    margin-top: 1em;
    margin-bottom: .5em;
}
.doc h2 {
    margin-top: 1.1428em;
    margin-bottom: .5714em;
}
.doc h3 {
    margin-top: 1.3333em;
    margin-bottom: .6666em;
}
.doc h4 {
    margin-bottom: .8em;
}
.doc h5 {
    margin-bottom: .8888em;
}
.doc h6 {
    margin-bottom: 1em;
}

.doc ol,
.doc ul {
    list-style: inherit;
    /* padding-left: 20px; */
    margin-left: 2em;
    margin-top: 1em;
    margin-bottom: 1em;
}

/* table thead th {
    white-space: nowrap;
} */
</style>


<script>
import global from '../global';

export default {
    data() {
        return {
            apiURL: 'http://bussgeldpruefer.local/backend/wp-json/wp/v2/docs?slug=',
            // apiURL: global.api.base + '/docs?slug=',
            docSlug: this.$route.params.docSlug,
            docs: [],
        }
    },

    methods: {
        fetchDocData: function() {
            let apiURL = this.apiURL + this.docSlug;

            console.log(apiURL);

            fetch(apiURL).then(resp => resp.json()).then(docsData => {
                let docData = docsData[0];
                let filteredData = {
                    id: docData.id,
                    title: docData.title.rendered,
                    content: docData.content.rendered
                };

                this.docs.push(filteredData);
            });
        }
    },

    beforeMount() {
        // console.log(this.docSlug);
        this.fetchDocData();
        console.log(this.docSlug);
    }
}
</script>
