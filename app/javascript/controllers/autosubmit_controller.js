import { Controller } from '@hotwired/stimulus';
import debounce from 'debounce';

export default class Autosubmit extends Controller {
  initialize() {
    this.debouncedSubmit = debounce(this.debouncedSubmit.bind(this), 300);
  }

  submit() {
    this.element.requestSubmit();
  }

  debouncedSubmit() {
    this.submit();
  }
}
