/* eslint-disable */

// NOTE: These won't get fired off unless they're in the
// production environment -- see app/views/shared/_ga.html.erb
// for the code doing that.
// format: ('_trackEvent', category, action, label, value)

window.addEventListener('DOMContentLoaded', () => {
  // see_lesson_buttons.html.erb for lesson button analytics

  // Fire an event when a user clicks on any discord invite link
  document.querySelectorAll('[href^="https://discord.gg/"]').forEach((a) => {
    a.addEventListener('click', () => {
      _gaq.push(['_trackEvent', 'chat', 'click_chat_link', 'lesson_page', 1]);
    });
  });

  // Fire an event whenever someone tries to sign in the standard way
  document.querySelector('input[value="Sign in"]')?.addEventListener('click', (e) => {
    _gaq.push(['_trackEvent', 'sign-in_buttons', 'click_normal_sign-in_button', 'sign-in_button', 1]);
  });

  // Fire an event whenever someone tries to sign up else sign in with Github by clicking the Github button
  document.querySelector('[data-test-id="github-btn"]')?.addEventListener('click', () => {
    if (window.location.pathname === '/sign_up') {
      _gaq.push(['_trackEvent', 'sign-up_buttons', 'click_github_sign-up button', 'github_sign-up_button', 1]);
    } else if (window.location.pathname === '/sign_in') {
      _gaq.push(['_trackEvent', 'sign-in_buttons', 'click_github_sign-in_button', 'github_sign-in_button', 1]);
    }
  });

  // Fire an event whenever someone tries to sign up else sign in with Google by clicking the Google button
  document.querySelector('[data-test-id="google-btn"]')?.addEventListener('click', () => {
    if (window.location.pathname === '/sign_up') {
      _gaq.push(['_trackEvent', 'sign-up_buttons', 'click_google_sign-up button', 'google_sign-up_button', 1]);
    } else if (window.location.pathname === '/sign_in') {
      _gaq.push(['_trackEvent', 'sign-in_buttons', 'click_google_sign-in_button', 'google_sign-in_button', 1]);
    }
  });

  // Fire an event whenever someone clicks the normal sign up button (e.g. not step 2 of the github flow)
  document.querySelector('input[value="Sign up"]')?.addEventListener('click', () => {
    _gaq.push(['_trackEvent', 'sign-up_buttons', 'sign_up', 'main_sign-up_button', 1]);
  });

  // Fire an event when a lesson is marked either complete or incomplete
  document.querySelectorAll('[data-complete-button-is-completed-value]').forEach((complete) => {
    complete.addEventListener('click', () => {
      if (complete.dataset.completeButtonIsCompletedValue === 'true') {
        _gaq.push(['_trackEvent', 'lesson_completion', 'mark_not_completed', window.location.href, 1]);
      } else if (complete.dataset.completeButtonIsCompletedValue === 'false') {
        _gaq.push(['_trackEvent', 'lesson_completion', 'mark_completed', window.location.href, 1]);
      }
    });
  });

  // Fire an event when a user clicks on the next lesson navigation link in the individual lesson page
  document.querySelector('[data-test-id="next-lesson-btn"]')?.addEventListener('click', () => {
    _gaq.push(['_trackEvent', 'lesson_navigation', 'click_next_lesson_link', 'lesson_page', 1]);
  });

  // Fire an event when a user clicks on dashboard resume button
  document.querySelectorAll('[data-test-id*="resume-btn"]').forEach((btn) => {
    btn.addEventListener('click', () => {
      _gaq.push(['_trackEvent', 'dashboard_buttons', 'resume', 'dashboard', 1]);
    });
  });

  // Fire an event when a user clicks on dashboard start button
  document.querySelectorAll('[data-test-id*="start-btn"]').forEach((btn) => {
    btn.addEventListener('click', () => {
      _gaq.push(['_trackEvent', 'dashboard_buttons', 'start', 'dashboard', 1]);
    });
  });

  // Fire an event when a user clicks on dashboard open button
  document.querySelectorAll('[data-test-id*="open-btn"]').forEach((btn) => {
    btn.addEventListener('click', () => {
      _gaq.push(['_trackEvent', 'dashboard_buttons', 'open', 'dashboard', 1]);
    });
  });
});
