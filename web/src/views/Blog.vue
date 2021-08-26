<template>
    <div class="container">
        <h1 class="text-secondary">Bussgeldratgeber</h1>
        <BlogSearch />
        <div class="mt-10">
            <router-link :to="{ name: 'blog-single' }">
                <BlogPreview imgsrc="/src/assets/img/alcohol.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein." />
            </router-link>

            <router-link :to="{ name: 'blog-single' }">
                <BlogPreview imgsrc="/src/assets/img/distance.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Abstand" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein." />
            </router-link>

            <router-link :to="{ name: 'blog-single' }">
                <BlogPreview imgsrc="/src/assets/img/parking.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein." />
            </router-link>

            <router-link :to="{ name: 'blog-single' }">
                <BlogPreview imgsrc="/src/assets/img/alcohol.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein." />
            </router-link>

            <!-- test -->
            <div v-for="bus in buss" :key="bus.id">
                <h2> Date - {{ bus.date }} </h2>
                <h2> Title - {{ bus.title.rendered }} </h2>
                <p> {{ bus.content.rendered }} </p>
                <p> {{ bus._embedded["wp:featuredmedia"][0].media_details.file }} </p>
                <p> {{ bus._embedded["wp:featuredmedia"][0].media_details.sizes.thumbnail.source_url }} </p>
            </div>
        </div>

        <button class="btn-primary mt-10 mx-auto block">Mehr laden</button>
    </div>
</template>
<script>
import BlogPreview from '../components/BlogPreview.vue'
import BlogSearch from '../components/BasicSearchForm.vue'

export default {
    components: {
        BlogPreview,
        BlogSearch
    },
    data() {
        return {
            buss: []
        }
    },

    created() {
    fetch('https://xn--bussgeldprfer-5ob.com/wp-json/wp/v2/posts?_embed&_fields=id,date,link,title,content,_links,_embedded')
      .then((res) => res.json())
      .then(data => this.buss = data)
      .catch(err => console.log(err.message))
    }
}
</script>