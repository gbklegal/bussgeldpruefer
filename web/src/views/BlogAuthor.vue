<template>
    <div class="container">
        <h1 class="text-secondary">AUTOR: {{ authorName }}</h1>
        <BlogSearch />
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

export default {
  components: {
    BlogPreview,
    BlogSearch,
    LoadingCircle
  },

  data() {
    return {
      apiURL: global.api.urlBuilder(),
      blogPosts: [],
      authorName: '',
      authorId: null,
      currentPage: 1,
      hideLoadMoreButton: false,
      hideLoadingCircle: true,
    };
  },

  methods: {
    getRandomInt(min, max) {
      return Math.floor(Math.random() * (max - min) ) + min;
    },
    removeHtmlTags: htmlString => {
      return htmlString.replace(/<[^>]*>/gim, '');
    },
    getAuthorIdBySlug: function(authorSlug, callback) {
      let apiURL = global.api.base + '?author_slug=' + authorSlug;
      fetch(apiURL).then(resp => resp.json()).then(data => {
        if (callback) callback(data.user.id);
      });
    },
    fetchPostData: function() {
      // display loading circle
      this.hideLoadingCircle = false;

      let apiURL = `${this.apiURL}&page=${this.currentPage}&author=${this.authorId}`;
      // if (this.searchQuery) {
      //   apiURL += '&search=' + this.searchQuery;
      // }

      let xhr = new XMLHttpRequest();
      let formData = new FormData();

      xhr.onreadystatechange = () => {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            let postsData = JSON.parse(xhr.responseText);
            this.authorName = postsData[0]._embedded.author[0].name;
            this.postCount = postsData.length;

            postsData.forEach(postData => {
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

                // hide loading circle
                this.hideLoadingCircle = true;
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
        console.log(respOK);
        if (!respOK) this.hideLoadMoreButton = true;

        this.fetchPostData();
        console.log('loadMorePosts');
      });
    }
    // fetchPostsDataByAuthorId: function(authorId) {
    //   fetch(this.apiURL + '&author=' + authorId)
    //     .then((res) => res.json())
    //     .then((postsData) => {
    //       // console.log(postsData);
    //       this.blogPosts = [];

    //       this.authorName = postsData[0]._embedded.author[0].name;
    //       console.log(this.authorName, this.$route.params.authorSlug, this.apiURL + '&author=' + this.$route.params.authorSlug);

    //       postsData.forEach(postData => {
    //           // console.log(postData);
    //           let filteredData = {
    //               id: postData.id,
    //               date: postData.modified, // date
    //               slug: postData.slug,
    //               title: postData.title.rendered,
    //               content: postData.content.rendered,
    //               contentPreview: this.removeHtmlTags(postData.content.rendered).substring(0, 250) + '...',
    //               images: {
    //                   full: postData._embedded['wp:featuredmedia'][0].source_url,
    //                   medium: postData._embedded['wp:featuredmedia'][0].media_details.sizes.medium.source_url,
    //                   thumbnail: postData._embedded['wp:featuredmedia'][0].media_details.sizes.thumbnail.source_url,
    //                   onepress: {
    //                       blogSmall: postData._embedded['wp:featuredmedia'][0].media_details.sizes['onepress-blog-small'].source_url,
    //                       small: postData._embedded['wp:featuredmedia'][0].media_details.sizes['onepress-small'].source_url,
    //                       medium: postData._embedded['wp:featuredmedia'][0].media_details.sizes['onepress-medium'].source_url
    //                   }
    //               },
    //               imageCaption: postData._embedded['wp:featuredmedia'][0].caption.rendered
    //           };

    //           this.blogPosts.push(filteredData)
    //       });
    //     })
    //     .catch((err) => console.error(err.message));
    // }
  },

  beforeMount() {
    this.getAuthorIdBySlug(this.$route.params.authorSlug, authorId => {
      this.authorId = authorId;
      this.fetchPostData();
    });
  }
};
</script>