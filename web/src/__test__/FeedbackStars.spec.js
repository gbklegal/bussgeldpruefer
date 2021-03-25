import { shallowMount } from '@vue/test-utils'
import FeedbackStars from '../components/FeedbackStars.vue'

describe('FeedbackStars', () => {
    const starLength = 5
    const wrapper = shallowMount(FeedbackStars, {
        propsData: { starLength }
    })
    const stars = wrapper.findAll('.star');

    test('renders the stars', () => {
        expect(stars.length).toBe(starLength);
    })
})