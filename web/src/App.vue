<template>
  <div class="text-primary">
    <Header />
    <main id="main">
      <router-view />
      <SocialMedia />
      <Warrants />
      <!-- <Badge /> -->
      <BackToTop />
    </main>
    <Footer />
  </div>
</template>

<script>
import Header from "./components/TheHeader.vue";
import Footer from "./components/TheFooter.vue";
import Badge from "./components/TheBadge.vue";
import BackToTop from "./components/TheBackToTop.vue";
import SocialMedia from "./components/BasicSocialMedia.vue";
import Warrants from "./components/BasicWarrants.vue";

export default {
  name: "App",
  components: {
    Header,
    Footer,
    Badge,
    BackToTop,
    SocialMedia,
    Warrants,
  },
};
</script>

<style>
#app {
  font-family: "Roboto" sans-serif;
  display: grid;
  grid-template-rows: max-content 1fr auto;
  min-height: 100vh;
  width: 100vw;
  max-width: 100%;
}

#main {
  max-width: 100%;
  position: relative;
}

#nav .logo .router-link-exact-active {
  background-color: #fff;
}

#nav .router-link-exact-active {
  background-color: #5cc8c5;
  color: #fff;
}

.catalog nav .router-link-exact-active {
  color: #5cc8c5;
}

.profile nav .router-link-active img,
.profile nav .router-link-exact-active img {
  background-color: #183b63;
}

.profile-mail nav .router-link-active,
.profile-mail nav .router-link-exact-active {
  color: #5cc8c5;
}

.profile-mail nav .router-link-active img,
.profile-mail nav .router-link-exact-active img {
  background-color: transparent;
}

@media screen and (prefers-reduced-motion: no-preference) {
  html {
    scroll-behavior: smooth;
  }
}
</style>
