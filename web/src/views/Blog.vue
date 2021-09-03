<template>
  <div class="container">
    <h1 class="text-secondary">Bussgeldratgeber</h1>
    <BlogSearch />
    <div class="mt-10" v-for="blogPost in blogPosts" :key="blogPost.id">
      <router-link :to="{ name: 'blog-single' }">
        <BlogPreview
          :imgsrc="blogPost.images.openpress.medium"
          :imgalt="blogPost.imageCaption"
          :blogtitle="blogPost.title"
          :previewtext="blogPost.content"
        />
      </router-link>
    </div>

    <button class="btn-primary mt-10 mx-auto block">Mehr laden</button>
  </div>
</template>
<script>
import BlogPreview from "../components/BlogPreview.vue";
import BlogSearch from "../components/BasicSearchForm.vue";

export default {
  components: {
    BlogPreview,
    BlogSearch,
  },
  data() {
    return {
      blogPosts: [],
    };
  },

  created() {
    fetch(
      "https://xn--bussgeldprfer-5ob.com/wp-json/wp/v2/posts?_embed&_fields=id,date,link,title,content,_links,_embedded"
    )
      .then((res) => res.json())
      .then((postsData) => {
        // console.log(postsData);
        this.blogPosts = [];

        postsData.forEach(postData => {
            // console.log(postData);
            let filteredData = {
                id: postData.id,
                date: postData.date,
                title: postData.title.rendered,
                content: postData.content.rendered,
                images: {
                    full: postData._embedded["wp:featuredmedia"][0].source_url,
                    medium: postData._embedded["wp:featuredmedia"][0].media_details.sizes.medium.source_url,
                    thumbnail: postData._embedded["wp:featuredmedia"][0].media_details.sizes.thumbnail.source_url,
                    openpress: {
                        blogSmall: postData._embedded["wp:featuredmedia"][0].media_details.sizes['onepress-blog-small'].source_url,
                        small: postData._embedded["wp:featuredmedia"][0].media_details.sizes['onepress-small'].source_url,
                        medium: postData._embedded["wp:featuredmedia"][0].media_details.sizes['onepress-medium'].source_url
                    }
                },
                imageCaption: postData._embedded["wp:featuredmedia"][0].caption.rendered
            };

            this.blogPosts.push(filteredData)
        });
      })
      .catch((err) => console.error(err.message));

  },
};
</script>