import { Controller } from '@hotwired/stimulus';
import { put } from '@rails/request.js';

export default class ThemeSwitcherController extends Controller {
  static values = {
    currentTheme: String,
    url: String,
  };

  connect() {
    const userThemePreference = this.currentThemeValue;

    this.updateTheme(userThemePreference);
    this.addThemeChangeListener(userThemePreference);
  }

  addThemeChangeListener(userThemePreference) {
    const themeChangeHandler = () => this.updateTheme(userThemePreference);
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', themeChangeHandler);
  }

  async handleThemeChangeRequest(event) {
    const { theme } = event.currentTarget.dataset;

    await this.updateThemeAndSendRequest(theme);
  }

  async updateThemeAndSendRequest(theme) {
    this.updateTheme(theme);
    await put(this.urlValue, { body: JSON.stringify({ theme }) });
  }

  updateTheme(theme) {
    const validThemes = ['light', 'dark'];
    const userSystemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    const selectedTheme = validThemes.includes(theme) ? theme : userSystemTheme;

    this.setUserTheme(selectedTheme);
  }

  // eslint-disable-next-line class-methods-use-this
  setUserTheme(theme) {
    const rootElement = document.getElementById('root-element');
    const availableThemes = ['system', 'light', 'dark'];

    availableThemes.forEach((t) => rootElement.classList.remove(t));
    rootElement.classList.add(theme);
  }
}
