<template>
  <div class="overflow-hidden home">
    <!-- HERO -->
    <Hero />

    <CTA
      title="Bußgeldbescheid erhalten?"
      subtitle="Punkte in Flensburg? Führerschein weg? Fahrverbot? MPU-Test? Geblitzt?"
    />

    <TextOne />

    <Steps />

    <Success />

    <CTA
      title="Kostenlose Prüfung, ob sich ein Einspruch gegen Deinen Bußgeldbescheid lohnt."
    />

    <!-- BLOG TEASER -->
    <section class="my-1 bg-primary">
      <div class="container font-light text-center text-white">
        <h2 class="mb-3 font-normal text-secondary">Bußgeld Ratgeber</h2>
        <p class="mb-10 text-secondary">Aktuelle Neuigkeiten, Änderungen &amp; Urteile zum Thema Bußgeld</p>

        <div v-if="!hideSkeleton">
          <Skeleton v-for="skeleton in postCount" :key="skeleton" type="blogPreview" />
        </div>

        <div v-for="blogPost in blogPosts" :key="blogPost.id">
          <router-link :to="{ name: 'blog-single', params: { postSlug: blogPost.slug } }">
            <BlogPreview
              :blogtitle="blogPost.title"
              :previewtext="blogPost.contentPreview"
              :imgsrc="blogPost.image"
              :imgalt="blogPost.imageCaption"
            />
          </router-link>
        </div>

        <router-link class="inline-block mt-10 font-normal text-white btn-primary" :to="{ name: 'blog' }">
          mehr erfahren
        </router-link>
      </div>
    </section>

    <!-- ClientFeedback -->
    <section>
      <div class="container">
        <h2 class="mb-10 text-center text-secondary">Kundenfeedback</h2>
        <div class="grid justify-center gap-20 mb-8 sm:grid-cols-3">
          <FeedbackItem :starCount="5" quote="Ich war anfangs total überfordert, aber das BussgeldPrüfer Team hat mir den gesamten Prozess abgenommen." author="Max B." />
          <FeedbackItem :starCount="5" quote="Super Service! In wenigen Tagen war alles geregelt - ohne großen Aufwand." author="Hannes K." />
          <FeedbackItem :starCount="5" quote="Alles Perfekt. Mein Führerschein ist wieder da." author="Michael T." />
        </div>
      </div>
    </section>

  </div>
</template>

<script>
import global from '../global';
import Hero from '../components/TheHero.vue'
import CTA from '../components/BasicCTA.vue'
import Steps from '../components/BasicSteps.vue'
import BlogPreview from '../components/BlogPreview.vue'
import TextOne from '../components/BasicSuccessOne.vue'
import Success from '../components/BasicSuccessTwo.vue'
import FeedbackItem from '../components/FeedbackItem.vue'
import Skeleton from '../components/BasicSkeleton.vue'

export default {
  name: 'Home',
  components: {
    Hero,
    CTA,
    Steps,
    BlogPreview,
    TextOne,
    Success,
    FeedbackItem,
    Skeleton
  },

  data() {
    return {
      apiURL: global.api.urlBuilder(),
      postCount: 2,
      blogPosts: [],
      hideSkeleton: false
    }
  },

  methods: {
    fetchPostData: function() {
      let apiURL = this.apiURL + '&per_page=' + this.postCount;

      fetch(apiURL).then(resp => resp.json()).then(postsData => {
        postsData.forEach(postData => {
          let filteredData = {
            id: postData.id,
            slug: postData.slug,
            title: postData.title.rendered,
            content: postData.content.rendered,
            contentPreview: global.removeHtmlTags(postData.content.rendered).substring(0, 250) + '...',
            image: postData._embedded["wp:featuredmedia"][0].media_details.sizes['onepress-medium'].source_url,
            imageCaption: postData._embedded["wp:featuredmedia"][0].caption.rendered
          };
          this.blogPosts.push(filteredData);
        });

        // hide skeleton
        this.hideSkeleton = true;
      });
    }
  },

  created() {
    // console.log(this.apiURL);
    this.fetchPostData();
  }
};
</script>

<style scoped>

@media (min-width: 1024px) {
  .first-half {
    grid-template-columns: calc(50vw - 512px) calc(512px - 1.5rem);
  }

  .second-half {
    grid-template-columns: calc(512px - 1.5rem) calc(50vw - 512px);
  }
}

@media (min-width: 1280px) {
  .first-half {
    grid-template-columns: calc(50vw - 640px) calc(640px - 1.5rem);
  }

  .second-half {
    grid-template-columns: calc(640px - 1.5rem) calc(50vw - 640px);
  }
}

@media (min-width: 1536px) {
  .first-half {
    grid-template-columns: calc(50vw - 768px) calc(768px - 1.5rem);
  }

  .second-half {
    grid-template-columns: calc(768px - 1.5rem) calc(50vw - 768px);
  }
}
</style>
