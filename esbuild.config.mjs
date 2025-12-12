#!/usr/bin/env node
//
// Esbuild is configured with 3 modes:
//
// `yarn build` - Build JavaScript and exit
// `yarn build --watch` - Rebuild JavaScript on change
// `yarn build --reload` - Reloads page when views, JavaScript, or stylesheets change
//
// Minify is enabled when "RAILS_ENV=production"
// Sourcemaps are enabled in non-production environments

import * as esbuild from 'esbuild'
import path from 'path'
import rails from 'esbuild-rails'
import chokidar from 'chokidar'
import http from 'http'
import { setTimeout } from 'timers/promises'
import { prismjsPlugin } from 'esbuild-plugin-prismjs'
import { sentryEsbuildPlugin } from '@sentry/esbuild-plugin'

const clients = []
const entryPoints = ['main.js']
const watchDirectories = [
  './app/javascript/**/*.js',
  './app/views/**/*.html.erb',
  './app/assets/builds/**/*.css' // Wait for cssbundling changes
]

const config = {
  absWorkingDir: path.join(process.cwd(), 'app/javascript'),
  bundle: true,
  logLevel: 'info',
  entryPoints,
  minify: process.env.RAILS_ENV === 'production',
  outdir: path.join(process.cwd(), 'app/assets/builds'),
  sourcemap: process.env.RAILS_ENV !== 'production',
  plugins: [
    rails(),
    prismjsPlugin({
      inline: true,
      languages: [
        'ruby',
        'javascript',
        'css',
        'markup',
        'sql',
        'erb',
        'jsx',
        'diff',
        'ejs',
        'bash',
        'properties',
        'json',
        'yaml'
      ],
      plugins: [
        'line-numbers',
        'toolbar',
        'copy-to-clipboard'
      ],
      css: true
    }),
    sentryEsbuildPlugin({
      authToken: process.env.SENTRY_AUTH_TOKEN,
      org: 'the-odin-project-web-app',
      project: 'the-odin-project',
      disable: process.env.RAILS_ENV !== 'production',
      sourcemaps: {
        assets: ['app/assets/builds/*.js', 'app/assets/builds/*.js.map']
      }
    })
  ]
}

async function buildAndReload () {
  // Foreman assigns a separate PORT for each process
  const port = parseInt(process.env.PORT)
  const context = await esbuild.context({
    ...config,
    banner: {
      js: ` (() => new EventSource("http://localhost:${port}").onmessage = () => location.reload())();`
    }
  })

  // Reload uses an HTTP server as an event stream to reload the browser
  http
    .createServer((req, res) => {
      return clients.push(
        res.writeHead(200, {
          'Content-Type': 'text/event-stream',
          'Cache-Control': 'no-cache',
          'Access-Control-Allow-Origin': '*',
          Connection: 'keep-alive'
        })
      )
    })
    .listen(port)

  await context.rebuild()
  console.log('[reload] initial build succeeded')

  let ready = false
  chokidar
    .watch(watchDirectories)
    .on('ready', () => {
      console.log('[reload] ready')
      ready = true
    })
    .on('all', async (event, path) => {
      if (ready === false) return

      if (path.includes('javascript')) {
        try {
          await setTimeout(20)
          await context.rebuild()
          console.log('[reload] build succeeded')
        } catch (error) {
          console.error('[reload] build failed', error)
        }
      }
      clients.forEach((res) => res.write('data: update\n\n'))
      clients.length = 0
    })
}

if (process.argv.includes('--reload')) {
  buildAndReload()
} else if (process.argv.includes('--watch')) {
  const context = await esbuild.context({ ...config, logLevel: 'info' })
  context.watch()
} else {
  esbuild.build(config)
}
