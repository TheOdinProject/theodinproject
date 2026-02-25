import { Controller } from '@hotwired/stimulus'
import TomSelect from 'tom-select'

export default class MultiSelectController extends Controller {
  connect () {
    this.tomSelect = new TomSelect(
      this.element,
      { create: true }
    )
  }

  disconnect () {
    if (this.tomSelect) {
      this.tomSelect.destroy()
    }
  }
}
