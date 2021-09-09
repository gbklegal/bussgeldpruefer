<template>
    <div class="container" v-if="!hideSkeleton">
        <Skeleton />
    </div>
    <div class="container" v-for="post in blogPost" :key="post.id">
        <img :src="post.image" :alt="post.imageCaption" class="rounded-sm object-cover h-4auto w-full">
        <h1 v-html="post.title" class="mt-5"></h1>
        <p>
            <span>Veröffentlicht am {{ formatDate(post.date) }} von <router-link :to="{ name: 'blog-author', params: { authorSlug: post.authorSlug } }" class="hover:underline">{{ post.author }}</router-link></span><br>
            <span class="text-sm">Lesedauer: {{ post.readingTime }}</span>
        </p>
        <hr class="my-4">
        <p v-html="post.content" class="text-justify"></p>
    </div>
</template>


<style>
h4 {
    font-weight: 500;
    font-size: 1.25rem;
    padding-bottom: 0.25rem;
}
</style>


<script>
import global from '../global';
import dayjs from 'dayjs';
import dayjsUpdateLocale from 'dayjs/plugin/updateLocale';
import Skeleton from '../components/BasicSkeleton.vue';

export default {
    components: {
        Skeleton
    },

    data() {
        return {
            postSlug: this.$route.params.postSlug,
            apiURL: global.api.urlBuilder() + '&slug=' + this.$route.params.postSlug,
            blogPost: [],
            hideSkeleton: false
        }
    },

    methods: {
        formatDate: dateString => {
            dayjs.extend(dayjsUpdateLocale);
            dayjs.updateLocale('en', {
                months: [
                    'Januar',
                    'Februar',
                    'März',
                    'April',
                    'Mai',
                    'Juni',
                    'Juli',
                    'August',
                    'September',
                    'Oktober',
                    'November',
                    'Dezember',
                ]
            });
            const date = dayjs(dateString);

            return date.format('DD. MMMM YYYY');
        },
        removeHtmlTags: htmlString => {
            return htmlString.replace(/<[^>]*>/gim, '');
        },
        readingTime: string => {
            const wordsCount = string.split(' ').length;
            const readingTime = Math.floor(wordsCount / 200);
            let timerText = '';

            if (readingTime > 1) {
                timerText = readingTime + ' Minuten';
            }
            else if (readingTime === 1) {
                timerText = readingTime + ' Minute';
            }
            else {
                readingTime = 1;
                timerText = '>' + readingTime + ' Minuten';
            }

            return timerText;
        }
    },

    created() {
        fetch(this.apiURL).then(resp => resp.json()).then(data => {
            this.hideSkeleton = true;

            let postData = data[0];
            let blogPostData = {
                id: postData.id,
                date: postData.date,
                modified: postData.modified,
                title: postData.title.rendered,
                content: postData.content.rendered,
                author: postData._embedded.author[0].name,
                authorSlug: postData._embedded.author[0].slug,
                image: postData._embedded["wp:featuredmedia"][0].source_url,
                imageCaption: postData._embedded["wp:featuredmedia"][0].caption.rendered,
                readingTime: this.readingTime(postData.content.rendered)
            };
            this.blogPost.push(blogPostData);
        });
    }
}
</script>