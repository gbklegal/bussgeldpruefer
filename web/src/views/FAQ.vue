<template>
    <div class="container">
        <h1 class="text-secondary">FAQ - Häufig gestellt Fragen</h1>
        <Search />
        <div class="mt-7" v-for="faq in faqs" :key="faq">
            <FAQItem :faqTitle="faq.question" :faqText="faq.answer" />
        </div>
    </div>
</template>
<script>
import global from '../global';
import Search from '../components/BasicSearchForm.vue'
import FAQItem from '../components/FAQItem.vue'

export default {
    components: {
        Search,
        FAQItem
    },

    data() {
        return {
            faqs: null
        }
    },

    methods: {
        getFAQData: function(callback) {
            let apiURL = global.api.bgp + '/force.php/faq'; // /faq.json

            fetch(apiURL).then(resp => resp.json()).then(faqData => {
                if (callback) callback(faqData);
            });
        }
    },

    beforeMount() {
        this.getFAQData(faqData => this.faqs = faqData);
    }
}
</script>