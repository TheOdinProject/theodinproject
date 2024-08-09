import { Controller } from '@hotwired/stimulus'
import { useClickOutside } from 'stimulus-use'
import { enter, leave } from 'el-transition'

// transitions are optional, but to use them add the el-transition data attributes listed below to content targets:
// https://github.com/mmccall10/el-transition#dataset-attributes
export default class VisibilityController extends Controller {
  static targets = ['content']

  static values = {
    visible: Boolean
  }

  connect () {
    useClickOutside(this)
  }

  disconnect () {
    this.contentTargets.forEach((element) => element.classList.toggle('hidden', true))
  }

  on () {
    this.visibleValue = true
  }

  off () {
    this.visibleValue = false
  }

  toggle () {
    this.visibleValue = !this.visibleValue
  }

  async visibleValueChanged (visible) {
    if (visible) {
      this.contentTargets.forEach((element) => enter(element))
    } else {
      for (const el of this.contentTargets.reverse()) {
        // each transition will wait for the previous one to finish
        await leave(el)
      }
    }
  }
}
