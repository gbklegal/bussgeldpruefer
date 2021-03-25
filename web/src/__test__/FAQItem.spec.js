import { shallowMount } from '@vue/test-utils';
import FAQItem from '../components/FAQItem.vue';

describe('FAQItem', () => {
    const faqTitle = 'new title';
    const faqText = 'some body text';
    const wrapper = shallowMount(FAQItem, {
        propsData: { faqTitle, faqText }
    });

    const title = wrapper.get('summary')
    const body = wrapper.get('.text')

    test('renders faq title', () => {
        expect(title.text()).toMatch(faqTitle);
    });

    test('renders faq body text', () => {
        expect(body.text()).toMatch(faqText);
    });
})