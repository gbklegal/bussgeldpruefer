import { shallowMount } from '@vue/test-utils'
import FeedbackText from '../components/FeedbackText.vue'

describe('FeedbackText', () => {
    const quote = 'some quotet text. Eg: It is all soo awesome here!'
    const author = 'Nina Y.'
    const wrapper = shallowMount(FeedbackText, {
        propsData: { quote, author }
    })
    const quotes = wrapper.findAll('p');

    test('renders quote', () => {
        expect(quotes[0].text()).toMatch(quote);
    })
})