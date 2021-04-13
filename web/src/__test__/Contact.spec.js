import { mount } from '@vue/test-utils';
import Contact from '../views/Contact.vue';

describe('Contact view-component', () => {

    test('sets the value for input with #firstname', async () => {
        const wrapper = mount(Contact)

        const firstName = wrapper.find('input#firstname')

        await firstName.setValue('firstname')

        expect(firstName.element.value).toBe('firstname')
    })

    test('sets the value for input with #lastname', async () => {
        const wrapper = mount(Contact)

        const lastName = wrapper.find('input#lastname')

        await lastName.setValue('lastname')

        expect(lastName.element.value).toBe('lastname')
    })

    test('sets the value for input with #email', async () => {
        const wrapper = mount(Contact)

        const eMail = wrapper.find('input#email')

        await eMail.setValue('some@mail.test')

        expect(eMail.element.value).toBe('some@mail.test')
    })

    test('sets the value for input with #phone', async () => {
        const wrapper = mount(Contact)

        const phone = wrapper.find('input#phone')

        await phone.setValue('0001111')

        expect(phone.element.value).toBe('0001111')
    })

    test('sets the value for textarea', async () => {
        const wrapper = mount(Contact)

        const message = wrapper.find('textarea')

        await message.setValue('some text for the textarea.')

        expect(message.element.value).toBe('some text for the textarea.')
    })

})