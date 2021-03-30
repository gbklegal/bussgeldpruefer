<template>
    <h2 class="text-xl">E-Mail schreiben</h2>

    <form @submit.prevent>
        <div class="border-2 border-gray-200 rounded-sm">
            <label class="ml-2" for="sendTo">An:</label>
            <input class="border-transparent" type="text" name="sendTo" id="sendTo">
        </div>
        <div class="border-2 border-t-0 border-gray-200 rounded-sm">
            <label class="ml-2" for="sendFrom">Von:</label>
            <input class="border-transparent" type="text" name="sendFrom" id="sendFrom">
        </div>
        <div class="border-2 border-t-0 border-gray-200 rounded-sm">
            <label class="ml-2" for="subject">Betreff:</label>
            <input class="border-transparent" type="text" name="subject" id="subject">
        </div>
        <div class="border-2 border-t-0 border-gray-200 rounded-sm">
            <textarea class="border-transparent" name="sendText" id="sendText" cols="30" rows="10"></textarea>
        </div>
        <button class="btn-primary mt-4" type="submit">senden</button>
    </form>

</template>