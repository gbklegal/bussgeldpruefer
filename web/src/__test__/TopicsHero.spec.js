import { shallowMount } from '@vue/test-utils'
import TopicsHero from '../components/TopicsHero.vue'

describe('TopicsHero', () => {
    const title = 'new title'
    const subtitle = 'some subtitle'
    /*const imgSrc = "url('/src/assets/img/redlight.jpg')"*/

    const wrapper = shallowMount(TopicsHero, {
        propsData: { title, subtitle /*, imgSrc*/ }
    })
    const h1 = wrapper.get('h1')
    const p = wrapper.get('p')
    const secHalf = wrapper.get('.second-half')

    test('renders title', () => {
        expect(h1.text()).toMatch(title);
    });

    test('renders subtitle', () => {
        expect(p.text()).toMatch(subtitle);
    })

    /*test('renders background-image', () => {
        expect(secHalf.html()).toContain(imgSrc)
    })*/

})