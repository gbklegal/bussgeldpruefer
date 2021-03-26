<template>
    <div class="container">
        <h1 class="text-secondary">Bussgeldratgeber</h1>
        <BlogSearch />
        <div class="mt-10">
            <BlogPreview imgsrc="/src/assets/img/alcohol.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein." />

            <BlogPreview imgsrc="/src/assets/img/alcohol.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein." />

            <BlogPreview imgsrc="/src/assets/img/alcohol.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein." />

            <BlogPreview imgsrc="/src/assets/img/alcohol.jpg" imgalt="Bild mit Alkohol" blogtitle="Führerscheinverlust bei Alkoholkonsum" previewtext="Die Tempo-30er-Zone erfüllt drei grundlegende Funktionen. So soll die 30-Zone die Verkehrssicherheit erhöhen. Aufgrund eines Verkehrssicherheitsprogrammes führte Berlin vor fast allen Schulen und Kitas die 30er Zone ein." />
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
    }
}
</script>