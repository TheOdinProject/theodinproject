import { Controller } from '@hotwired/stimulus';

export default class ClipboardController extends Controller {
  static targets = ['source', 'message'];

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value);

    if (this.hasMessageTarget) {
      this.messageTarget.classList.remove('hidden');
      setTimeout(() => {
        this.messageTarget.classList.add('hidden');
      }, 2000);
    }
  }
}
