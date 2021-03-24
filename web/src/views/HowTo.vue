<template>
    <div class="container how-to">
        <h1>Wie funktioniert's</h1>
        <section class="my-14 grid">
            <img class="mx-auto border-4 rounded-full border-white w-32 h-32" src="../assets/img/assignment.svg" alt="Icon mit Dokumenten">
            <h2 class="text-secondary">Formular ausfüllen &amp; Dokumente einreichen</h2>
            <div class="how-to-text max-w-3xl">
                <p class="mb-2">Um Du erfolgreich gegen den Bußgeldbescheid vorzugehen, klicke auf
                <router-link class="underline" to="/bussgeldbescheid-pruefen">
                Bussgeldbescheid Prüfung
                </router-link>
                , damit Deine Daten erfasst werden können.</p>
                <p class="mb-2">Für die schnelle Bearbeitung Deines Falles brauchen wir mind. folgende Unterlagen:<br>Bußgeldbescheid, Anhörungsbogen, Vollmacht.</p>
                <p class="mb-2">Du bist Dir nicht sicher, ob man gegen Dein Bußgeldbescheid vorgehen kann? Dann nutze den kostenlosen Quick-Check, um in 90 Sekunden zu fahren, ob sich ein Einspruch lohnt.</p>
                <p class="mb-2">In diesem Schritt fallen keine Kosten an und Du schließt keinen Vertrag mit BussgeldPrüfer ab.</p>
            </div>
        </section>

        <section class="my-14 grid">
            <img class="mx-auto border-4 rounded-full border-white w-32 h-32" src="../assets/img/communication.svg" alt="Icon mit Personen.">
            <h2 class="text-secondary">Fallbesprechung mit Partnerkanzlei</h2>
            <div class="how-to-text max-w-3xl">
                <p class="mb-2">Wenn alle nötigen Dokumente eingereicht wurden, wird ein Verkehrsrecht-Anwalt deinen Fall prüfen und sich bei Dir melden. Die telefonische Beratung ist in jedem Fall unverbindlich. Du kannst danach selbst entscheiden, ob Du gegen deinen Bußgeldbescheid vorgehen möchtest oder nicht.</p>
                <p class="mb-2">In der Fallbesprechung mit dem Partneranwalt wird eine Verteidigungsstrategie ausgearbeitet, damit Du Dich wieder frei im Verkehr bewegen kannst.</p>
                <p class="mb-2">Das setzt voraus, dass Du entweder das Formular "Bußgeldbescheid Prüfung" ausgefüllt hast oder mit der Anwaltskanzlei Kontakt aufgenommen hast und dass Du alle wichtigen Dokument zugesendet hast.</p>
                <p class="mb-2">Den aktuellen Status deines Falls kannst Du jederzeit in der App überprüfen.</p>
            </div>
        </section>

        <section class="my-14 grid">
            <img class="mx-auto border-4 rounded-full border-white w-32 h-32" src="../assets/img/innovation.svg" alt="Icon mit Lupe.">
            <h2 class="text-secondary">Überprüfung</h2>
            <div class="process-text max-w-3xl">
                <p class="mb-2">Im 3. Schritt hast Du eingewilligt rechtlich gegen Deinen Bußgeldbescheid vorzugehen. Der Verkehrsrechtanwalt wird Deinen Fall vor Gericht verteidigen auf der Basis der Verteidigungsstrategie.</p>
                <p class="mb-2">Das Gericht wird nun Dein Anliegen überprüfen. BussgeldPrüfer ist deutschlandweit tätig. Das kann ein paar Tage in Anspruch nehmen.</p>
            </div>
        </section>

        <section class="my-14 grid">
            <img class="mx-auto border-4 rounded-full border-white w-32 h-32" src="../assets/img/sentence.svg" alt="Icon mit Richterhammer.">
            <h2 class="text-secondary">Urteil</h2>
            <div class="process-text max-w-3xl">
                <p class="mb-2">Sobald das Urteil gefallen ist, wirst Du sofort benachrichtigt. In der BussgeldPrüfer App wirst Du immer über den aktuellen Stand Deines Verfahrens informiert.</p>
                <p class="mb-2">Es dauert max. X Tage bis Du eine Rückmeldung vom Gericht bekommst.</p>
            </div>
        </section>
    </div>
    <CTA title="Kostenlose Prüfung ob sich ein Einspruch gegen Deinen Bußgeldbescheid lohnt." />
    <Warrants />
</template>

<script>
import CTA from '../components/BasicCTA.vue'
import Warrants from '../components/BasicWarrants.vue'

export default {
    name: 'Process',
    components: {
        Warrants,
        CTA,
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