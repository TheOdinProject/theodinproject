import { Controller } from '@hotwired/stimulus'
import mermaid from 'mermaid'

export default class DiagrammingController extends Controller {
  connect () {
    mermaid.initialize({ startOnLoad: false, theme: 'dark' })
    mermaid.init()
  }
}
