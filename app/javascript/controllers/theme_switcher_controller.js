import { Controller } from '@hotwired/stimulus';

export default class ThemeSwitcherController extends Controller {
  connect() {
    const userThemePreference = this.getUserThemePreference();
    this.updateTheme(userThemePreference);
    window.matchMedia('(prefers-color-scheme: dark)')
      .addEventListener('change', () => this.updateTheme(userThemePreference));
  }

  updateTheme(userThemePreference) {
    const rootElement = this.getRootElement();

    if (!['light', 'dark'].includes(userThemePreference)) {
      const userSystemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
      this.setUserTheme(rootElement, userSystemTheme);
    } else {
      this.setUserTheme(rootElement, userThemePreference);
    }
  }

  getUserThemePreference() {
    this.name = 'theme';
    const cookies = document.cookie.split(';');
    let themePreference = null;

    cookies.forEach((cookie) => {
      const trimmedCookie = cookie.trim();
      if (trimmedCookie.startsWith(`${this.name}=`)) {
        themePreference = trimmedCookie.substring(this.name.length + 1);
      }
    });

    return themePreference;
  }

  // eslint-disable-next-line class-methods-use-this
  setUserTheme(rootElement, theme) {
    rootElement.removeAttribute('class');
    rootElement.classList.add(theme);
  }

  // eslint-disable-next-line class-methods-use-this
  getRootElement() {
    return document.getElementById('root-element');
  }
}
