<template>
  <div class="container">
    <h1 class="text-secondary">Bussgeldratgeber</h1>
    <BlogSearch />

    <div v-if="!hideSkeleton">
      <Skeleton v-for="skeleton in skeletonCount" :key="skeleton" type="blogPreview" />
    </div>

    <div class="mt-10" v-for="blogPost in blogPosts" :key="blogPost.id">
      <router-link :to="{ name: 'blog-single', params: { postSlug: blogPost.slug } }">
        <BlogPreview
          :imgsrc="blogPost.images.onepress.medium"
          :imgalt="blogPost.imageCaption"
          :blogtitle="blogPost.title"
          :previewtext="blogPost.contentPreview"
        />
      </router-link>
    </div>

    <div class="mt-10 mx-auto w-8" v-if="!hideLoadingCircle">
      <LoadingCircle />
    </div>
    <button v-if="!hideLoadMoreButton" class="btn-primary mt-10 mx-auto block" @click="loadMorePosts">Mehr laden</button>
  </div>
</template>


<script>
import global from '../global';
import BlogPreview from "../components/BlogPreview.vue";
import BlogSearch from "../components/BasicSearchForm.vue";
import LoadingCircle from "../components/BasicLoadingCircle.vue";
import Skeleton from '../components/BasicSkeleton.vue';

export default {
  components: {
    BlogPreview,
    BlogSearch,
    LoadingCircle,
    Skeleton
  },

  data() {
    return {
      apiURL: global.api.urlBuilder(),
      blogPosts: [],
      searchQuery: this.$route.query.search || '',
      postCount: 0,
      currentPage: 1,
      hideLoadMoreButton: false,
      hideLoadingCircle: true,
      hideSkeleton: false,
      skeletonCount: 10,
    };
  },

  watch: {
    $route() {
      this.fetchPostData();
    }
  },

  methods: {
    getRandomInt(min, max) {
      return Math.floor(Math.random() * (max - min) ) + min;
    },
    removeHtmlTags: htmlString => {
      return htmlString.replace(/<[^>]*>/gim, '');
    },
    fetchPostData: function() {
      // display loading circle
      this.hideLoadingCircle = false;

      let apiURL = this.apiURL + '&page=' + this.currentPage
      if (this.searchQuery) {
        apiURL += '&search=' + this.searchQuery;
      }

      // console.log(apiURL);

      let xhr = new XMLHttpRequest();
      let formData = new FormData();

      xhr.onreadystatechange = () => {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            let postsData = JSON.parse(xhr.responseText);

            // console.log(postsData);
            // this.blogPosts = [];
            this.postCount = postsData.length;
            
            if (this.postCount < 10) {
              this.hideLoadMoreButton = true;
            }

            postsData.forEach(postData => {
                // console.log(postData);
                let filteredData = {
                    key: this.getRandomInt(100, 999),
                    id: postData.id,
                    date: postData.modified, // date
                    slug: postData.slug,
                    title: postData.title.rendered,
                    content: postData.content.rendered,
                    contentPreview: this.removeHtmlTags(postData.content.rendered).substring(0, 250) + '...',
                    images: {
                        full: postData._embedded["wp:featuredmedia"][0].source_url,
                        medium: postData._embedded["wp:featuredmedia"][0].media_details.sizes.medium.source_url,
                        thumbnail: postData._embedded["wp:featuredmedia"][0].media_details.sizes.thumbnail.source_url,
                        onepress: {
                            blogSmall: postData._embedded["wp:featuredmedia"][0].media_details.sizes['onepress-blog-small'].source_url,
                            small: postData._embedded["wp:featuredmedia"][0].media_details.sizes['onepress-small'].source_url,
                            medium: postData._embedded["wp:featuredmedia"][0].media_details.sizes['onepress-medium'].source_url
                        }
                    },
                    imageCaption: postData._embedded["wp:featuredmedia"][0].caption.rendered
                };

                this.blogPosts.push(filteredData)

                // hide loading circle and skeleton
                this.hideLoadingCircle = true;
                this.hideSkeleton = true;
            });
          } else {
            this.hideLoadMoreButton = true;
          }
        }
      };
      xhr.open('GET', apiURL, true);
      xhr.send(formData);

      // fetch(apiURL)
      //   .then(resp => resp.json())
      //   .then(postsData => {
          
      //   })
      //   .catch((err) => console.error(err));
    },
    checkNextPage: function(callback) {
      let nextPageNumber = this.currentPage + 1;
      fetch(this.apiURL + '&page=' + nextPageNumber).then(resp => {
        if (callback) callback(resp.ok);
      });
    },
    loadMorePosts: function() {
      this.hideLoadingCircle = false;
      this.currentPage += 1;
      this.checkNextPage(respOK => {
        if (!respOK) this.hideLoadMoreButton = true;

        this.fetchPostData();
        console.log('loadMorePosts');
      });
    }
  },

  created() {
    console.log(this.apiURL);
    this.fetchPostData();
  }
};
</script>