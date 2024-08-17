import { Controller } from '@hotwired/stimulus'

export default class ScrollToController extends Controller {
  static values = {
    offset: { type: Number, default: 25 },
    behavior: { type: String, default: 'smooth' }
  }

  connect () {
    this.element.dataset.action = 'scroll-to#scrollTo'
  }

  scrollTo (event) {
    event.preventDefault()

    const id = this.element.hash || this.element.value
    const targetElement = document.querySelector(id)
    const targetElementPosition = targetElement.getBoundingClientRect().top + window.pageYOffset

    window.scrollTo({
      top: targetElementPosition - this.offsetValue,
      behavior: this.behaviorValue
    })
  }
}
