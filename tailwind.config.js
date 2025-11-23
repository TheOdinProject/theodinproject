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
    },
  },
}
