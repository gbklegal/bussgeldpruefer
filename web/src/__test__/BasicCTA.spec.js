import { shallowMount } from '@vue/test-utils'
import BasicCTA from '../components/BasicCTA.vue'

describe('BasicCTA', () => {
    it('renders props.title when passed', () => {
        const title = 'new title';
        const wrapper = shallowMount(BasicCTA, {
            propsData: { title }
        });
        expect(wrapper.text()).toMatch(title);
    });
});