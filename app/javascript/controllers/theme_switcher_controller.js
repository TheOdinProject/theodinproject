import { Controller } from '@hotwired/stimulus';

export default class ThemeSwitcherController extends Controller {
  static values = {
    theme: String,
  };

  connect() {
    const userThemePreference = this.getUserThemePreference();
    this.updateTheme(userThemePreference);
    window.matchMedia('(prefers-color-scheme: dark)')
      .addEventListener('change', () => this.updateTheme(userThemePreference));
  }

  updateTheme(userThemePreference) {
    if (!['light', 'dark'].includes(userThemePreference)) {
      const userSystemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
      this.setUserTheme(userSystemTheme);
    } else {
      this.setUserTheme(userThemePreference);
    }
  }

  getUserThemePreference() {
    return this.themeValue;
  }

  // eslint-disable-next-line class-methods-use-this
  setUserTheme(theme) {
    const rootElement = document.getElementById('root-element');
    rootElement.removeAttribute('class');
    rootElement.classList.add(theme);
  }
}
