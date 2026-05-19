import { Controller } from '@hotwired/stimulus'

const FULLY_VISIBLE = 1

export default class StickyStateController extends Controller {
  static classes = ['stuck']

  connect () {
    this.observer = new window.IntersectionObserver(
      ([entry]) => this.toggleStuck(entry.intersectionRatio < FULLY_VISIBLE),
      { threshold: [FULLY_VISIBLE] }
    )

    this.observer.observe(this.element)
  }

  disconnect () {
    this.observer?.disconnect()
  }

  toggleStuck (stuck) {
    this.stuckClasses.forEach((cls) => this.element.classList.toggle(cls, stuck))
  }
}
