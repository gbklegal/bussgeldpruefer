<template>
    <div class="feedback-item flex flex-col">
        <FeedbackStars :starCount="starCount" />
        <FeedbackText :quote="quote" :author="author" />
    </div>
</template>


<script>
import FeedbackStars from './FeedbackStars.vue';
import FeedbackText from './FeedbackText.vue';

export default {
    components: {
        FeedbackStars,
        FeedbackText
    },

    props: {
        starCount: Number,
        quote: String,
        author: String,
    }
}
</script>