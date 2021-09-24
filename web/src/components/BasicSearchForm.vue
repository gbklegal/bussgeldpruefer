<template>
    <p v-if="!noHeader" class="text-xl">Themenübersicht</p>
    <div class="relative mt-8" v-if="!fastSearch">
        <input type="text" name="search-query" @keyup.enter="submit()" v-model="searchQuery" id="searchQuery" placeholder="Nach welchem Thema suchst Du?"
        class="w-72 block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50">
        <label for="searchQuery" class="absolute">Nach welchem Thema suchst Du?</label>
        <button type="submit" @click.stop.prevent="submit()">
            <img src="/src/assets/img/search.svg" alt="Icon mit Lupe" class="w-5 absolute" />
        </button>
    </div>
    <div class="relative" v-if="fastSearch">
        <input type="text" name="search-query" :oninput="oninput" id="fastSearchQuery" placeholder="Nach welchem Thema suchst Du?"
        class="w-72 mt-8 block mb-3 rounded border-primary border-2 focus:ring focus:border-secondary focus:ring-secondary focus:ring-opacity-50">
        <label for="fastSearchQuery" class="absolute">Nach welchem Thema suchst Du?</label>
        <img src="/src/assets/img/search.svg" alt="Icon mit Lupe" class="w-5 absolute" />
    </div>
</template>


<style lang="scss" scoped>
    // floating labels
    label {
    top: 0.6rem;
    left: 0.5rem;
    transition: all 0.3s ease;
    }

    input::placeholder {
    opacity: 0;
    }

    input:focus + label,
    input:not(:placeholder-shown) + label {
    top: -1.6rem;
    left: 0;
    font-size: 0.8em;
    } 

    img {
        top: 0.8rem;
        left: 16rem;
    }
</style>


<script>
export default {
    name: 'Search',
    props: {
        url: String,
        fastSearch: Boolean,
        oninput: Function,
        noHeader: Boolean
    },

    data() {
        return {
            searchQuery: null
        }
    },

    methods: {
        submit() {
            // TODO: replace reload with rerender
            // this.$router.push('/ratgeber?search=' + encodeURIComponent(this.searchQuery))
            // window.location.href = '/ratgeber?search=' + encodeURIComponent(this.searchQuery);
            window.location.href = this.url + '?search=' + encodeURIComponent(this.searchQuery);
        }
    },

    mounted() {
        let urlSearchQuery = this.$route.query.search;
        if (urlSearchQuery) {
            document.querySelector('#searchQuery').value = urlSearchQuery;
        }
    }
}
</script>
