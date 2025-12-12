import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['likeCount']

  static values = {
    likeCount: String
  }

  likeCountTargetConnected (element) {
    const currentLikeCount = element.innerText

    if (currentLikeCount !== this.likeCountValue) {
      this.likeCountValue = currentLikeCount
    }
  }

  likeCountValueChanged (value) {
    const sortCode = this.element.dataset.sortCode

    if (sortCode !== value) {
      this.element.dataset.sortCode = value
    }
  }
}
