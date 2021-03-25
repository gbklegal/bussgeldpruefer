module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        primary: {
          hover: '#214E82',
          DEFAULT: '#183B63',
        },
        secondary: {
          hover: '#4FB9B5',
          DEFAULT: '#5CC8C5',
        }
      },
      fontFamily: {
        'sans': ['Roboto', 'sans-serif'],
      },
      maxWidth: {
        '1/2': '50%',
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
}