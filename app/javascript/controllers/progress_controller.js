import { Controller } from '@hotwired/stimulus'

export default class ProgressController extends Controller {
  static targets = ['progressCircle']

  static values = {
    percent: Number,
    circumference: Number
  }

  connect () {
    const offset = this.circumferenceValue - (this.percentValue / 100) * this.circumferenceValue
    setTimeout(() => { this.progressCircleTarget.style.strokeDashoffset = offset }, 200)
  }
}
