import { Controller } from '@hotwired/stimulus';

export default class HandleThemeController extends Controller {
  connect() {
    function getCookie(name) {
      const cookies = document.cookie.split(';');
      for (const cookie of cookies) {
        const trimmedCookie = cookie.trim();
        if (trimmedCookie.startsWith(`${name}=`)) {
          return trimmedCookie.substring(name.length + 1);
        }
      }
      return null;
    }

    const userThemePreference = getCookie('theme');
    const rootElement = document.getElementById('root-element');

    const setUserTheme = (theme) => {
      rootElement.removeAttribute('class');
      rootElement.classList.add(theme);
    };

    const updateTheme = () => {
      if (!['light', 'dark'].includes(userThemePreference)) {
        const userSystemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
        setUserTheme(userSystemTheme);
      }
    };

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', updateTheme);

    if (userThemePreference === 'system') {
      const userSystemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
      setUserTheme(userSystemTheme);
    } else {
      setUserTheme(userThemePreference);
    }
  }
}
