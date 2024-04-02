import { Controller } from '@hotwired/stimulus';

export default class OptionSelector extends Controller {
  static targets = ['option', 'buttonText', 'button', 'resetButton'];

  connect() {
    this.initialButtonText = this.buttonTarget.textContent;
  }

  select(event) {
    this.optionTargets.forEach((element) => element.removeAttribute('data-selected', 'false'));
    event.currentTarget.setAttribute('data-selected', 'true');
    this.buttonTextTarget.textContent = `Confirm ${event.currentTarget.dataset.name}`;
    this.buttonTarget.removeAttribute('disabled');
    this.resetButtonTarget.classList.remove('hidden');
  }

  reset() {
    this.optionTargets.forEach((element) => element.removeAttribute('data-selected', 'true'));
    this.buttonTextTarget.textContent = this.initialButtonText;
    this.buttonTarget.setAttribute('disabled', 'true');
    this.resetButtonTarget.classList.add('hidden');
  }
}
