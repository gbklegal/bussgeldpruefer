<template>
  <div class="text-primary">
    <Header v-if="!isFrameMode" :isLimitedView="isLimitedView" />
    <main id="main">
      <router-view />
      <SocialMedia v-if="!isFrameMode" />
      <Certificates v-if="!isFrameMode" />
      <!-- <Badge /> -->
      <BackToTop v-if="!isFrameMode" />
    </main>
    <Footer v-if="!isFrameMode" :isLimitedView="isLimitedView" />
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
  data() {
    return {
      isFrameMode: false,
      isLimitedView: false,
    }
  },
  watch: {
    '$route': {
        handler(route) {
          // check if query frame_mode is set
          // app_mode is deprecated
          let isFrameMode = (route.query.frame_mode === null || route.query.app_mode === null);
          let routeName = route.name;

          if (routeName === 'fa-landing') {
            this.isFrameMode = true;
            this.isLimitedView = true;
          }

          if (isFrameMode === true)
            this.isFrameMode = isFrameMode;
        }
      }
  },
  mounted() {
    // const nav = document.querySelector('header nav#nav');
    // const main = document.querySelector('main#main');

    // function calcMainNavDistance() {
    //   let navHeight = nav.offsetHeight;
    //   main.style.marginTop = navHeight + 'px';
    // }

    // window.addEventListener('resize', calcMainNavDistance);
    // calcMainNavDistance();
  }
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

/* #nav {
  background-color: #fff;
  z-index: 999;
  position: fixed;
  top: 0;
  right: 0;
  left: 0;
} */

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
