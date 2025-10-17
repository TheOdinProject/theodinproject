import { Controller } from '@hotwired/stimulus'
import { useClickOutside } from 'stimulus-use'

export default class extends Controller {
  static targets = ['dialog', 'content']

  connect () {
    this.element.dialog = this
    useClickOutside(this, { element: this.contentTarget })
  }

  open () {
    this.dialogTarget.showModal()
  }

  close () {
    this.dialogTarget.close()
  }

  submitEnd (event) {
    if (event.detail.success) {
      this.close()
    }
  }

  onKeydown (event) {
    if (event.key === 'Escape') {
      this.close()
    }
  }
}
