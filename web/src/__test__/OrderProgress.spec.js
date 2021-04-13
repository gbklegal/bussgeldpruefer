import { shallowMount } from '@vue/test-utils'
import OrderProgress from '../components/OrderProgress.vue'

describe('OrderProgress component', () => {
    const percentage = 50
    const text = 'some text'
    const wrapper = shallowMount(OrderProgress, {
        propsData: { text, percentage }
    })

    const label = wrapper.get('label')
    const progress = wrapper.get('progress')

    test('renders text prop in label element', () => {
        expect(label.text()).toMatch(text)
    })

    test('renders percentage prop in progress element', () => {
        expect(progress.text()).toBe(percentage + '%')
    })
})