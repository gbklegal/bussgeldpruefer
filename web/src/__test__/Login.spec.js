import { ref } from '@vue/reactivity';
import { shallowMount } from '@vue/test-utils';
import Login from '../views/Login.vue';

describe('Login view-component', () => {

    test('sets the value for input with #email', async () => {
        const wrapper = shallowMount(Login)

        const eMail = wrapper.find('input#email')

        await eMail.setValue('my@email.mail')

        expect(eMail.element.value).toBe('my@email.mail')
    })

    test('sets the value for input with #password', async () => {
        const wrapper = shallowMount(Login)

        const password = wrapper.find('input#password')

        await password.setValue('some_password123')

        expect(password.element.value).toBe('some_password123')
    })

    test('sets type of input #password to password when hidden=true', () => {
        const wrapper = shallowMount(Login)

        const password = wrapper.find('input#password')

        expect(password.element.type).toBe('password')
    })

    test('sets type of input #password to text when clicked on button inside .password-input', async () => {
        const wrapper = shallowMount(Login)
        const password = wrapper.find('input#password')

        await wrapper.find('.password-input button').trigger('click')

        expect(password.element.type).toBe('text')
    })
})