import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['dialog']

  open ({ params: { id } }) {
    const element = this.dialogTargets.find(dialog => dialog.id === id)

    element.dialog.open()
  }
}
