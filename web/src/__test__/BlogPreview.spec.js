import { shallowMount } from '@vue/test-utils'
import BlogPreview from '../components/BlogPreview.vue'

describe('BlogPreview', () => {
    const blogtitle = 'new title'
    const previewtext = 'some describing text'
    const imgsrc = 'some-image.png'
    const imgalt = 'some describing alt text.'

    const wrapper = shallowMount(BlogPreview, {
        props: { blogtitle, previewtext, imgsrc, imgalt }
    })
    const h3 = wrapper.get('h3')
    const p = wrapper.get('p')
    const img = wrapper.get('img')

    test('renders blogtitle prop', () => {
        expect(h3.text()).toMatch(blogtitle);
    });

    test('renders previewtext prop', () => {
        expect(p.text()).toMatch(previewtext);
    })

    test('renders imgsrc prop', () => {
        expect(img.attributes('src')).toMatch(imgsrc);
    })

    test('renders imgalt prop', () => {
        expect(img.attributes('alt')).toMatch(imgalt);
    })
})