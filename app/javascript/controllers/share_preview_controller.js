import { Controller } from '@hotwired/stimulus';
import { post } from '@rails/request.js';

export default class SharePreviewController extends Controller {
  static targets = ['input', 'button'];

  static values = { url: String };

  connect() {
    this.inputTarget.addEventListener('input', this.toggleButton.bind(this));
  }

  async share(e) {
    e.preventDefault();

    const content = this.inputTarget.value;
    await post(this.urlValue, { body: JSON.stringify({ content }) });
  }

  toggleButton() {
    this.buttonTarget.classList.toggle('hidden', this.inputTarget.value.length === 0);
  }
}
