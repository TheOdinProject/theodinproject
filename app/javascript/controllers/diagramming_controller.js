import { Controller } from '@hotwired/stimulus'
import mermaid from 'mermaid'

export default class DiagrammingController extends Controller {
  connect () {
    this.render()
  }

  async render () {
    mermaid.initialize({ startOnLoad: false, theme: 'dark' })
    await mermaid.run()
  }
}
