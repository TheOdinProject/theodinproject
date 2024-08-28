import { Controller } from '@hotwired/stimulus'
import mermaid from 'mermaid'

export default class DiagrammingController extends Controller {
  async connect () {
    const isMarkdownPreview = Boolean(document.querySelector('#preview-container'))
    const querySelector = isMarkdownPreview ? ':not(.hidden) > #preview-container .mermaid' : '.mermaid'

    mermaid.initialize({ startOnLoad: false, theme: 'dark' })
    await mermaid.run({ querySelector })
  }
}
