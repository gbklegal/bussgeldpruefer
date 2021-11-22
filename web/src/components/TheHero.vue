<template>
    <header class="w-full bg-secondaryLight py-12" id="hero">
        <div class="container">
            <div class="hero-inner">
                <div>
                    <header>
                        <h2>Bußgeld­bescheid fehlerhaft?</h2>
                        <h3>Jetzt Einspruch einlegen!</h3>
                    </header>

                    <main>
                        <div class="we-help">
                            <h4>Wir helfen</h4>
                            <p>
                                <span>
                                    <i class="fa fa-check text-green"></i>zeitsparend
                                </span>
                                <br>
                                <span>
                                    <i class="fa fa-check text-green"></i>unkompliziert
                                </span>
                                <br>
                                <span>
                                    <i class="fa fa-check text-green"></i>geldsparend
                                </span>
                            </p>
                        </div>
                        <div class="btns-wrapper">
                            <router-link class="btn btn-primary" :to="{ name: 'order' }">Bußgeldbescheid kostenlos prüfen lassen</router-link>
                            <div class="mt-4"></div>
                            <router-link class="btn btn-secondary" :to="{ name: 'not-found' }">Jetzt den Quick Check machen</router-link>
                        </div>
                    </main>
                </div>

                <div class="screenshot-wrapper"> <img src="../assets/img/img01_iphone12.png" class="screenshot">
                    <div class="bg-secondary floating-icons img-time"> <img src="../assets/img/hero-time.png"></div>
                    <div class="bg-greyDark floating-icons img-add"> <img src="../assets/img/hero-add.png"></div>
                    <div class="bg-grey floating-icons img-speed-camera"> <img src="../assets/img/hero-speed-camera.png"></div>
                </div>
            </div>
        </div>
    </header>
</template>


<style lang="scss" scoped>
#hero {
    position: relative;

    &::before {
        position: absolute;
        top: auto;
        left: 0;
        bottom: -50px;
        content: '';
        background-image: url('../assets/img/hero-ellipse-left.svg');
        width: 69px;
        height: 424px;
    }

    &::after {
        position: absolute;
        top: 0;
        right: 0;
        content: '';
        background-image: url('../assets/img/hero-ellipse-right.svg');
        width: 43px;
        height: 424px;
    }

    .hero-inner {
        display: flex;
    }

    header {
        h2,
        h3 {
            line-height: 1;
        }

        h2 {
            font-size: 54px;
            font-weight: 700;
        }

        h3 {
            font-size: 54px;
            font-weight: 400;
        }
    }

    span {
        i {
            padding-right: 5px;
        }
    }

    main {
        padding-top: 20px;
        display: flex;
    }

    .we-help {
        padding-right: 50px;

        h4 {
            font-size: 36px;
            font-weight: 700;
            white-space: nowrap;
        }

        span {
            font-size: 30px;
            white-space: nowrap;
        }
    }

    .btn {
        width: 100%;
        font-size: 18px;
        padding: 20px 40px;
        text-align: center;
    }

    img.screenshot {
        width: 240px;
    }

    .screenshot-wrapper {
        display: grid;
        place-items: center;
        position: relative;
        width: 500px;
        max-width: 100%;
        margin: 0 auto;

        .floating-icons {
            position: absolute;
            width: 110px;
            height: 110px;
            padding: 10px;
            border-radius: 20px;
        }

        .floating-icons.img-time {
            bottom: 100px;
            left: 30px;
        }

        .floating-icons.img-speed-camera {
            top: 50px;
            right: 55px;
            width: 90px;
            height: 90px;
        }

        .floating-icons.img-add {
            bottom: 125px;
            right: 70px;
            width: 70px;
            height: 70px;
        }
    }
}
@media (max-width: 1023px) {
    #hero {
        .hero-inner {
            flex-direction: column;
        }
    }
}
@media (max-width: 570px) {
    #hero {
        main {
            flex-direction: column;
        }
        .we-help {
            margin: 0 auto;
            padding-right: 0px;
            padding-bottom: 20px;
        }
    }
}
</style>