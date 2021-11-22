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
    },
    /**
     * encrypt and decrypt mail to
     * @see https://www.math.uni-hamburg.de/it/dienste/encryptma.html
     * @param {string} s 
     * @returns 
     */
    linkTo_UnCryptMailto(s) {
        function unCryptMailto(s) {
            var n = 0; var r = ''; for (var i = 0; i < s.length; i++) {
                n = s.charCodeAt(i);
                if (n >= 8364) { n = 128; } r += String.fromCharCode(n - (1));
            }
            return r;
        }

        location.href = unCryptMailto(s);
    }
}