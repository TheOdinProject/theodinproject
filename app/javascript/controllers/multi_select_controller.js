import { Controller } from '@hotwired/stimulus'
import SlimSelect from 'slim-select'

export default class MultiSelectController extends Controller {
  connect() {
    new SlimSelect({
      select: this.element,
      events: {
        addable: function(value) { return value; }
      }
    })
  }
}
