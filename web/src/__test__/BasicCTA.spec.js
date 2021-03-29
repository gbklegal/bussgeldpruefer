import { shallowMount } from '@vue/test-utils'
import BasicCTA from '../components/BasicCTA.vue'

describe('BasicCTA', () => {
    const smallText = 'some small teaser text'
    const title = 'new title'
    const subtitle = 'some subtitle'

    const wrapper = shallowMount(BasicCTA, {
        propsData: { title, subtitle, smallText }
    })
    const h2 = wrapper.get('h2')
    const p = wrapper.get('p')
    const span = wrapper.get('span')

    test('renders title', () => {
        expect(h2.text()).toMatch(title);
    });

    test('renders subtitle', () => {
        expect(p.text()).toMatch(subtitle)
    })

    test('renders smalltext', () => {
        expect(span.text()).toMatch(smallText)
    })
})