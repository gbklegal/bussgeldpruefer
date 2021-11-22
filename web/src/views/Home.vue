<template>
  <div class="home overflow-hidden">
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
      title="Kostenlose Prüfung ob sich ein Einspruch gegen Deinen Bußgeldbescheid lohnt."
    />

    <!-- BLOG TEASER -->
    <section class="bg-primary my-1">
      <div class="container text-white text-center font-light">
        <h2 class="text-secondary font-normal mb-3">Bußgeld Ratgeber</h2>
        <p class="text-secondary mb-10">Aktuelle Neuigkeiten, Änderungen &amp; Urteile zum Thema Bußgeld</p>

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

        <router-link class="btn-primary text-white font-normal inline-block mt-10" to="/ratgeber">
          mehr erfahren
        </router-link>
      </div>
    </section>

    <!-- ClientFeedback -->
    <section>
      <div class="container">
        <h2 class="text-secondary text-center mb-10">Kundenfeedback</h2>
        <div class="grid sm:grid-cols-3 gap-3 justify-center mb-8">
          <FeedbackStars :starCount="5" />
          <FeedbackStars :starCount="5" />
          <FeedbackStars :starCount="4" />
        </div>
        <div>
          <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." author="Melis Y." />
          <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." author="Melis Y." />
          <FeedbackText quote="Ich war anfangs total überfordert, aber das BussgeldPruefer hat mir den gesamten Prozess abgenommen." author="Melis Y." />
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
import FeedbackStars from '../components/FeedbackStars.vue'
import FeedbackText from '../components/FeedbackText.vue'
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
    FeedbackStars,
    FeedbackText,
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
    console.log(this.apiURL);
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
