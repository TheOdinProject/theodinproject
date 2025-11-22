// @tailwindcss/typography still requires JS config to customise the CSS (as of v0.5.19)
module.exports = {
  theme: {
    extend: {
      typography: {
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
                color: 'var(--colors-gray-800)',
                'text-decoration': 'none',
                'font-weight': '600',
                '&:hover': {
                  color: 'var(--colors-gray-800)',
                }
              },
            },
            h4: {
              a: {
                'text-decoration': 'none',
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
            '--tw-prose-code': 'var(--colors-pink-700)',
            '--tw-prose-invert-code': 'var(--colors-pink-400)',          },
        },
      },
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
}
