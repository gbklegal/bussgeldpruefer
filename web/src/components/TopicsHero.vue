<template>
  <!-- HERO -->
    <header class="lg:flex w-full overflow-hidden">
      <div class="first-half my-20 lg:max-w-1/2 lg:grid">
        <div></div>
        <div class="container lg:pr-4 lg:px-0 lg:container-half-left">
          <h1 class="text-4xl md:text-5xl mb-6">
              {{ title }}
          </h1>
          <p class="text-xl">
            {{ subtitle }}
          </p>
        </div>
      </div>

      <div class="second-half w-full h-96 lg:h-auto my-1 bg-cover bg-center bg-no-repeat" :style="{ backgroundImage: 'url(' + imgSrc + ')' }">
        
      </div>
    </header>
</template>
<script>
export default {
    props: {
        title: String,
        subtitle: String,
        imgSrc: String,
    }
}
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