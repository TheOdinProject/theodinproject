import { Controller } from '@hotwired/stimulus';

export default class SwitcherController extends Controller {
  static values = {
    currentTheme: String,
    otherTheme: String,
  };

  toggle() {
    document.documentElement.classList.remove(this.currentThemeValue);
    document.documentElement.classList.add(this.otherThemeValue);
  }
}
