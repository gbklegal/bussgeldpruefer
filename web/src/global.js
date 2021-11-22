export default {
    api: {
        domain: 'https://bussgeldpruefer.com',
        bgp: 'https://bussgeldpruefer.com/bgp',
        base: 'https://bussgeldpruefer.com/bgp/wp-api.php',
        wp: '/wp-json/wp/v2/',
        type: '/posts',
        filter: '?_embed&_fields=id,date,modified,slug,link,title,content,_links,_embedded',
        urlBuilder: function(type, withFilter) {
            return this.base + this.type + this.filter
            // return this.base + this.wp + type + (withFilter ? this.filter : '');
        }
    },
    date: {
        currentYear: (new Date).getFullYear(),
    },
    removeHtmlTags: htmlString => {
        return htmlString.replace(/<[^>]*>/gim, '');
    }
}