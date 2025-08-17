import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['dialog']

  connect () {
    console.log('Dialog Router connected')
  }

   open ({ params: { id } }) {
    const element = this.dialogTargets.find(dialog => dialog.id === id)

    element.dialog.open()
  }
}
