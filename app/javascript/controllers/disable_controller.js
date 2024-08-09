import { Controller } from '@hotwired/stimulus'

export default class DisableController extends Controller {
  static targets = ['element']

  disable () {
    this.elementTarget.setAttribute('disabled', 'true')
  }

  enable () {
    this.elementTarget.removeAttribute('disabled')
  }
}
