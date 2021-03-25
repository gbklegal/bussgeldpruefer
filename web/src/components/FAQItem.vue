<template>
    <details>
        <summary>{{ faqTitle }}</summary>
        <div class="text">{{ faqText }}</div>
    </details>
</template>
<script>
export default {
    props: {
        faqTitle: String,
        faqText: String,
    }
}
</script>
