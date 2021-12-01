<template>
    <div class="container how-to">
        <h1>Wie funktioniert's</h1>
        <section class="grid my-14">
            <img class="w-32 h-32 mx-auto border-4 border-white rounded-full" src="../assets/img/assignment.svg" alt="Icon mit Dokumenten">
            <h2 class="text-secondary">Formular ausfüllen &amp; Dokumente einreichen</h2>
            <div class="max-w-3xl how-to-text">
                <p class="mb-2">Um erfolgreich gegen den Bußgeldbescheid vorzugehen, klicke auf
                <router-link class="underline" :to="{ name: 'order' }">
                Bußgeldbescheid Prüfung</router-link>,
                damit Deine Daten erfasst werden können.</p>
                <p class="mb-2">Für die schnelle Bearbeitung Deines Falles brauchen wir mindestens folgende Unterlagen:<br>Bußgeldbescheid, Anhörungsbogen, Vollmacht.</p>
                <p class="mb-2">Du bist Dir nicht sicher, ob man gegen Deinen Bußgeldbescheid vorgehen kann? Dann nutze den kostenlosen Quick-Check in der <a href="/app" class="underline">App</a>, um in 90 Sekunden zu erfahren, ob sich ein Einspruch lohnt.</p>
                <p class="mb-2">In diesem Schritt fallen keine Kosten an.</p>
            </div>
        </section>

        <section class="grid my-14">
            <img class="w-32 h-32 mx-auto border-4 border-white rounded-full" src="../assets/img/communication.svg" alt="Icon mit Personen">
            <h2 class="text-secondary">Fallbesprechung mit Partnerkanzlei</h2>
            <div class="max-w-3xl how-to-text">
                <p class="mb-2">Wenn alle nötigen Dokumente eingereicht wurden, wird ein Verkehrsrecht-Anwalt Deinen Fall kostenlos ersteinschätzen und sich bei Dir melden. Die Beratung ist in jedem Fall unverbindlich. Du kannst danach selbst entscheiden, ob Du gegen deinen Bußgeldbescheid vorgehen möchtest oder nicht.</p>
                <p class="mb-2">In der Fallbesprechung mit dem Partneranwalt wird eine Verteidigungsstrategie ausgearbeitet, damit Du Dich wieder frei im Verkehr bewegen kannst.</p>
                <p class="mb-2">Dies setzt voraus, dass Du entweder das Formular "Bußgeldbescheid Prüfung" ausgefüllt hast oder mit der Anwaltskanzlei Kontakt aufgenommen sowie alle wichtigen Dokument zugesendet hast.</p>
                <p class="mb-2">Den aktuellen Status Deines Falls kannst Du jederzeit in der App überprüfen.</p>
            </div>
        </section>

        <section class="grid my-14">
            <img class="w-32 h-32 mx-auto border-4 border-white rounded-full" src="../assets/img/innovation.svg" alt="Icon mit Lupe">
            <h2 class="text-secondary">Überprüfung</h2>
            <div class="max-w-3xl process-text">
                <p class="mb-2">Im dritten Schritt hast Du eingewilligt rechtlich gegen Deinen Bußgeldbescheid vorzugehen. Der Verkehrsrechtanwalt wird Deinen Fall vor der Behörde, und auch notfalls vor Gericht auf der Basis der Verteidigungsstrategie verteidigen.</p>
                <p class="mb-2">Die zuständige Behörde wird nun Dein Anliegen überprüfen. BussgeldPrüfer ist deutschlandweit tätig. Dies kann ein paar Tage in Anspruch nehmen.</p>
            </div>
        </section>

        <section class="grid my-14">
            <img class="w-32 h-32 mx-auto border-4 border-white rounded-full" src="../assets/img/sentence.svg" alt="Icon mit Richterhammer">
            <h2 class="text-secondary">Urteil</h2>
            <div class="max-w-3xl process-text">
                <p class="mb-2">Sobald eine Entscheidung oder Urteil gefallen ist, wirst Du sofort benachrichtigt. In der BussgeldPrüfer App wirst Du immer über den aktuellen Stand Deines Verfahrens informiert.</p>
                <p class="mb-2">Die Dauer der Rückmeldung von der zuständigen Behörde variiert je Einzelfall und Bundesland.</p>
            </div>
        </section>
    </div>
    <CTA title="Kostenlose Prüfung ob sich ein Einspruch gegen Deinen Bußgeldbescheid lohnt" />
</template>

<script>
import CTA from '../components/BasicCTA.vue'

export default {
    name: 'Process',
    components: {
        CTA
    }
}
</script>

<style scoped>
    .how-to {
        counter-reset: heading;
    }

    h2:before {
        counter-increment: heading;
        content: counter(heading) ". ";
    }

    @media (min-width: 640px) {
        section {
        grid-template-areas:
            'img title'
            'img text';

        grid-template-columns: auto 1fr;
        }

        img {
        grid-area: img;
        align-self: center;
        margin-right: 2em;
        }

        h2 {
        grid-area: title;
        }

        .how-to-text {
        grid-area: text;
    }
    }
</style>