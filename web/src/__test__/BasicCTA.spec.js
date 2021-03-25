import { shallowMount } from '@vue/test-utils'
import BasicCTA from '../components/BasicCTA.vue'

describe('BasicCTA', () => {
    const title = 'new title'
    const subtitle = 'some subtitle'
    const wrapper = shallowMount(BasicCTA, {
        propsData: { title, subtitle }
    })
    const h2 = wrapper.get('h2')
    const p = wrapper.get('p')

    test('renders title', () => {
        expect(h2.text()).toMatch(title);
    });

    test('renders subtitle', () => {
        expect(p.text()).toMatch(subtitle)
    })
})