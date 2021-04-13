import { mount } from '@vue/test-utils'
import TheBadge from '../components/TheBadge.vue'

describe('TheBadge component', () => {
    test('renders the .badge-container if hideBadge is false', () => {
        const wrapper = mount(TheBadge, {
            data() {
                return {
                    hideBadge: false
                }
            }
        })
        expect(wrapper.find('.badge-container'));

    })

    test('does not render the .badge-container if hideBadge is true', () => {
        const wrapper = mount(TheBadge, {
            data() {
                return {
                    hideBadge: true
                }
            }
        })
        expect(wrapper.find('.badge-container').exists()).toBe(false);
    })

    test('if hideBadge is false and .badge-container is clicked, .badge-container is not rendered', async () => {
        const wrapper = mount(TheBadge, {})
        await wrapper.find('.badge-container').trigger('click')

        expect(wrapper.find('.badge-container').exists()).toBe(false);
    })
})