import { Controller } from '@hotwired/stimulus';

export default class ThemeSwitcherController extends Controller {
  connect() {
    const userThemePreference = this.getUserThemePreference();
    const rootElement = document.getElementById('root-element');

    const setUserTheme = (theme) => {
      rootElement.removeAttribute('class');
      rootElement.classList.add(theme);
    };

    const updateTheme = () => {
      if (!['light', 'dark'].includes(userThemePreference)) {
        const userSystemTheme = this.getUserSystemTheme();
        setUserTheme(userSystemTheme);
      }
    };

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', updateTheme);

    this.setInitialTheme(userThemePreference);
  }

  getUserThemePreference() {
    const name = 'theme';
    const cookies = document.cookie.split(';');
    for (const cookie of cookies) {
      const trimmedCookie = cookie.trim();
      if (trimmedCookie.startsWith(`${name}=`)) {
        return trimmedCookie.substring(name.length + 1);
      }
    }
    return null;
  }

  getUserSystemTheme() {
    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }

  setInitialTheme(userThemePreference) {
    if (userThemePreference === 'system') {
      const userSystemTheme = this.getUserSystemTheme();
      this.setUserTheme(userSystemTheme);
    } else {
      this.setUserTheme(userThemePreference);
    }
  }

  setUserTheme(theme) {
    const rootElement = document.getElementById('root-element');
    rootElement.removeAttribute('class');
    rootElement.classList.add(theme);
  }
}
