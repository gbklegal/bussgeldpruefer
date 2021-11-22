<template>
    <Skeleton type="catalogSingle" v-if="!hideSkeleton" />
    <div v-for="doc in docs" :key="doc.id" class="doc">
        <h2 class="text-secondary" v-html="doc.title"></h2>
        <!-- <div id="toc"></div> -->
        <p v-html="doc.content" class="catalog-content"></p>
    </div>
</template>


<script>
import global from '../global';
import Skeleton from '../components/BasicSkeleton.vue';

export default {
    components: {
        Skeleton
    },

    data() {
        return {
            apiURL: global.api.base + '/docs?slug=',
            docSlug: this.$route.params.docSlug,
            docs: [],
            hideSkeleton: false
        }
    },

    methods: {
        fetchDocData: function() {
            this.hideSkeleton = false;
            let fields = '&_fields=id,title,content';
            let apiURL = this.apiURL + this.docSlug + fields;

            console.log(apiURL);

            fetch(apiURL).then(resp => resp.json()).then(docsData => {
                let docData = docsData[0];
                let filteredData = {
                    id: docData.id,
                    title: docData.title.rendered,
                    content: docData.content.rendered
                };

                this.docs.push(filteredData);

                // hide loading circle
                this.hideSkeleton = true;
            });
        },
        loadTableOfContents: function() {
            global.tableOfContents({
                'target': '#toc',
                'parent': '.catalog-content'
            });
        }
    },

    beforeMount() {
        this.fetchDocData();
        console.log(this.docSlug);
    }
}
</script>


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
    margin-bottom: .5714em;
}
.doc h2:not(:first-child) {
    margin-top: 1.1428em;
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