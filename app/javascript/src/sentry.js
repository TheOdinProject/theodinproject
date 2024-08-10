/* eslint-disable no-undef, no-unused-expressions */

const {
  SENTRY_DSN, currentUserSignedIn, currentUserId, currentUsername,
} = window;

window.Sentry = window.Sentry || {};
window.Sentry && Sentry.onLoad && Sentry.onLoad(() => {
  Sentry.init({
    dsn: SENTRY_DSN,
    environment: 'production',
    debug: true,
  });

  if (currentUserSignedIn) {
    Sentry.setUser({
      id: currentUserId,
      name: currentUsername,
    });
  }
});
