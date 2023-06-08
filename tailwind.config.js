module.exports = {
  content: [
    './app/**/*.html.erb',
    './app/components/**/*',
    './app/components/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/components/**/*.jsx',
    'app/assets/images/icons/*.svg',
    './config/utility_classes.yml',
    './app/components/**/*.yml',
    './app/builders/**/*.rb',
  ],
  safelist: [
    'lesson-note',
    'lesson-note--tip',
    'lesson-note--warning',
    'lesson-content__panel',
    'anchor-link',
    'toc-item-active'
  ],
  darkMode: 'class',
  theme: {
    extend: {
      typography: (theme) => ({
        DEFAULT: {
          css: {
            code: {
              '&:before': {
                display: 'none',
              },
              '&:after': {
                display: 'none',
              },
            },
            h3: {
              width: 'fit-content',
              a: {
                color: theme('colors.gray.800'),
                'text-decoration': 'none',
                'font-weight': '600',
                '&:hover': {
                  color: theme('colors.gray.800'),
                }
              },
            },
            details: {
              summary: {
                'font-size': '1.25rem',
                'margin-bottom': '1.25rem',
                'font-weight': '600',
                'cursor': 'pointer',
              },
            }
          },
        },
        gray: {
          css: {
            '--tw-prose-code': theme('colors.pink.700'),
            '--tw-prose-invert-code': theme('colors.pink.400'),
          },
        },
      }),
      colors: {
        transitionProperty: {
          'stroke-dashoffset': 'stroke-dashoffset'
        },
        'gold': {
          DEFAULT: '#CE973E',
          '50': '#F3E6D0',
          '100': '#EFDDC0',
          '200': '#E7CCA0',
          '300': '#DFBA7F',
          '400': '#D6A95F',
          '500': '#CE973E',
          '600': '#A9792B',
          '700': '#7C5920',
          '800': '#503914',
          '900': '#231909'
        },
      },
    },
  },
  corePlugins: {
    container: false,
  },
  plugins: [
    require('@tailwindcss/typography'),
    require("@tailwindcss/forms"),
  ],
}
