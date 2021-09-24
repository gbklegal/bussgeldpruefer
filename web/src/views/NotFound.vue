<template>
    <div class="flex flex-col items-center py-16">
        <h2>Seite nicht gefunden</h2>
        <BlogSearch url="/ratgeber/" :noHeader="true" />
    </div>
</template>


<script>
import BlogSearch from "../components/BasicSearchForm.vue";

export default {
    components: {
        BlogSearch,
    },
}
</script>