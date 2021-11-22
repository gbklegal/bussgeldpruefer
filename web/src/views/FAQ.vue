<template>
    <div class="container">
        <h1 class="text-secondary">FAQ - Häufig gestellt Fragen</h1>
        <Search />

        <div v-if="!hideSkeleton">
            <Skeleton v-for="skeleton in skeletonCount" :key="skeleton" type="faqItem" />
        </div>

        <div class="mt-7" v-for="faq in faqs" :key="faq">
            <FAQItem :faqTitle="faq.question" :faqText="faq.answer" />
        </div>
    </div>
</template>
<script>
import global from '../global';
import Search from '../components/BasicSearchForm.vue'
import FAQItem from '../components/FAQItem.vue'
import Skeleton from '../components/BasicSkeleton.vue'

export default {
    components: {
        Search,
        FAQItem,
        Skeleton
    },

    data() {
        return {
            faqs: null,
            skeletonCount: 15,
            hideSkeleton: false
        }
    },

    methods: {
        getFAQData(callback) {
            let apiURL = global.api.bgp + '/force.php/faq'; // /faq.json

            fetch(apiURL).then(resp => resp.json()).then(faqData => {
                if (callback) callback(faqData);
            });
        }
    },

    beforeMount() {
        // load faq data
        this.getFAQData(faqData => {
            this.faqs = faqData;
            // hide skeleton after the data is loaded
            this.hideSkeleton = true;
        });
    }
}
</script>