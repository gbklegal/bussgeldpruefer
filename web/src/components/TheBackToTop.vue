<template>
<!-- TODO: Problem with pages that are 100vh or smaller -->
    <div class="p-2 absolute rounded-full text-primary">
        <a href="#header">
            <svg class="w-10 bg-white rounded-full" role="img" aria-labelledby="bttLabel" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <title id="bttLabel">nach Oben</title>
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-8.707l-3-3a1 1 0 00-1.414 0l-3 3a1 1 0 001.414 1.414L9 9.414V13a1 1 0 102 0V9.414l1.293 1.293a1 1 0 001.414-1.414z" clip-rule="evenodd" />
            </svg>
        </a>
    </div>
</template>
<script>
export default {
    name: 'BackToTop',
}
</script>
<style scoped>
    div {
        --scroll-length: 100vh;
        top: var(--scroll-length);
        right: 2rem;
        bottom: -1rem;
        width: 3em;
        pointer-events: none;
    }

    a {
        /* position fixed as fallback */
        position: fixed;
        position: sticky;
        pointer-events: all;
        top: calc(100vh - 5rem);
    }
</style>