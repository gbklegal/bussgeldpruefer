<template>
    <div id="loadingCircle" class="inline-block">
        <svg class="circular-loader" viewBox="25 25 50 50">
            <circle class="loader-path" cx="50" cy="50" r="20" fill="none" stroke="#70c542" stroke-width="4" />
        </svg>
    </div>
</template>


<style>
.circular-loader {
    -webkit-animation: rotate 2s linear infinite;
    animation: rotate 2s linear infinite;
    height: 100%;
    -webkit-transform-origin: center center;
    -ms-transform-origin: center center;
    transform-origin: center center;
    width: 100%;
    position: relative;
    top: 0;
    left: 0;
    margin: auto;
    width: 2.75em;
    height: 2.75em;
}

.loader-path {
    stroke-dasharray: 150,200;
    stroke-dashoffset: -10;
    -webkit-animation: dash 1.5s ease-in-out infinite, color 6s ease-in-out infinite;
    animation: dash 1.5s ease-in-out infinite, color 6s ease-in-out infinite;
    stroke-linecap: round;
}
@-webkit-keyframes rotate {
    100% {
        -webkit-transform: rotate(360deg);
        transform: rotate(360deg);
    }
}
@keyframes rotate {
    100% {
        -webkit-transform: rotate(360deg);
        transform: rotate(360deg);
    }
}
@keyframes dash {
    0% {
        stroke-dasharray: 1,200;
        stroke-dashoffset: 0;
    }

    50% {
        stroke-dasharray: 89,200;
        stroke-dashoffset: -35;
    }

    100% {
        stroke-dasharray: 89,200;
        stroke-dashoffset: -124;
    }
}
@keyframes color {
    0% {
        stroke: rgb(92, 200, 197);
    }

    40% {
        stroke: rgb(92, 200, 197);
    }

    66% {
        stroke: rgb(92, 200, 197);
    }

    80%,
    90% {
        stroke: rgb(92, 200, 197);
    }
}
</style>


<script>
// export default {
//     name: 'LoadingCircle'
// }
</script>