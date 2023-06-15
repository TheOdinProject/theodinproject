import { Controller } from '@hotwired/stimulus';

export default class CssToggleController extends Controller {
  static targets = ['element'];

  static classes = ['from', 'to'];

  toggle() {
    this.elementTargets.forEach((element) => {
      element.classList.toggle(...this.toClasses);
      element.classList.toggle(...this.fromClasses);
    });
  }
}
