import { Controller } from '@hotwired/stimulus'

export default class ProgressController extends Controller {
  static targets = ['progressCircle']

  static values = {
    percent: Number,
  }

  connect () {
    const percentageRemaining = 100 - this.percentValue

    if (this.progressCircleTarget.getAttribute('stroke-dashoffset') !== percentageRemaining) {
      this.progressCircleTarget.setAttribute('stroke-dashoffset', percentageRemaining)
    }
  }
}
