import * as Sentry from '@sentry/browser'

const {
  SENTRY_DSN, currentUserSignedIn, currentUserId, currentUsername
} = window

if (SENTRY_DSN) {
  Sentry.init({
    dsn: SENTRY_DSN,
    environment: 'production'
  })

  if (currentUserSignedIn) {
    Sentry.setUser({
      id: currentUserId,
      name: currentUsername
    })
  }
}
