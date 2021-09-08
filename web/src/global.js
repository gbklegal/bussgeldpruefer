export default {
    api: {
        // base: 'https://xn--bussgeldprfer-5ob.com',
        base: 'https://xn--bussgeldprfer-5ob.com/bgp/wp-api.php',
        bgp: 'https://xn--bussgeldprfer-5ob.com/bgp',
        wp: '/wp-json/wp/v2/',
        type: 'posts',
        filter: '?_embed&_fields=id,date,modified,slug,link,title,content,_links,_embedded',
        urlBuilder: function(type, withFilter) {
            return this.base + this.wp + this.type + this.filter
            // return this.base + this.wp + type + (withFilter ? this.filter : '');
        }
    }
}