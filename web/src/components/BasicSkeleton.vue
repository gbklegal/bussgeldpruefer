<template>
    <div class="skeleton">
        <div class="skeleton-box w-full h-96"></div>
        <div class="skeleton-box w-50 h-10 mt-5"></div>
        <div class="skeleton-box w-1/3 h-6 mt-6"></div>
        <div class="skeleton-box w-1/4 h-6 mt-1"></div>
        <hr class="my-4">
        <div class="skeleton-box w-full h-10 mt-5"></div>
        <div class="skeleton-box w-full h-40 mt-5"></div>
        <div class="skeleton-box w-full h-40 mt-5"></div>
    </div>
</template>


<style>
.skeleton {
    position: relative;
    overflow: hidden;
}

.skeleton::after {
    top: 0;
    position: absolute;
    content: '';
    background-image: linear-gradient( 100deg, transparent, rgba(255, 255, 255, 0.5) 50%, transparent 80% );
    background-repeat: repeat-y;
    left: -100%;
    width: 100px;
    height: 100%;
    animation: 1s shine infinite;
}

.skeleton-box {
    background-color: lightgrey;
}

@keyframes shine {
    to {
        left: 100%;
    }
}
</style>


<script>
export default {
    name: 'Skeleton',
    props: {
        type: String
    }
}
</script>