import { Controller } from '@hotwired/stimulus'
import SlimSelect from 'slim-select'
import 'slim-select/styles'

export default class MultiSelectController extends Controller {
  connect () {
    this.slimSelect = new SlimSelect({
      select: this.element,
      events: {
        addable: function (value) { return value }
      }
    })
  }

  disconnect () {
    this.slimSelect.destroy()
  }
}
