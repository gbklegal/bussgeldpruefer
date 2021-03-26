<template>
    <details class="bg-gray-200 rounded my-4">
        <summary class="pl-7 cursor-pointer p-2 my-2 relative">{{ faqTitle }}</summary>
        <!-- TODO: add animation https://css-tricks.com/how-to-animate-the-details-element-using-waapi/ -->
        <div class="text ml-7 pb-2" v-html="faqText"></div>
    </details>
</template>
<script>
export default {
    props: {
        faqTitle: String,
        faqText: String,
    }
}
</script>
<style lang="scss" scoped>
details[open] > summary {
    border-bottom: 0.2rem solid #4FB9B5;
}

// remove default marker 
details > summary {
  list-style: none;
}

details summary::-webkit-details-marker {
  display:none;
}

// add custom marker
summary:before {
  content: '';
  border-width: 0.4rem 0.6rem;
  border-style: solid;
  border-color: transparent transparent transparent #4FB9B5;
  position: absolute;
  top: 0.9em;
  left: 0.5em;
  transform: rotate(0);
  transform-origin: .2rem 50%;
  transition: .25s transform ease;
}

// rotate it when details is open
details[open] > summary:before {
  transform: rotate(90deg);
}

</style>