# AGENTS.md

## Project Overview

The Odin Project is a Rails 8 application that provides a free, open-source coding curriculum. Users follow learning paths composed of courses and lessons, submit projects, and track their progress.

## References

- **Git commit & PR format:** See [.github/PULL_REQUEST_TEMPLATE.md](.github/PULL_REQUEST_TEMPLATE.md). Commit titles must follow `keyword: brief description` using one of: `Feature`, `Chore`, or `Fix`.

## Tech Stack

- **Backend:** Rails 8.0, Ruby 3.4, PostgreSQL
- **Frontend:** Tailwind CSS 4, Stimulus, Turbo Rails, esbuild
- **Components:** ViewComponent (app/components/)
- **Background Jobs:** Sidekiq with sidekiq-cron
- **Auth:** Devise with OmniAuth (GitHub, Google) and two-factor support
- **Testing:** RSpec, Capybara with Cuprite, FactoryBot, WebMock/VCR
- **Error Tracking:** Sentry
- **Feature Flags:** Flipper

## Common Commands

### Development

```bash
bin/setup          # Initial setup (bundle, yarn, db:prepare, etc.)
bin/dev            # Start dev server (Puma + Sidekiq + CSS/JS watchers)
```

### Testing

```bash
bin/test                              # Full suite: all linters + RSpec
bin/rspec                             # RSpec only (parallel execution)
bin/rspec spec/models/user_spec.rb    # Single file
bin/rspec spec/models/user_spec.rb:42 # Single example by line number
```

### Linting

```bash
bin/rubocop              # Ruby linting
bin/erb_lint --lint-all  # ERB template linting
yarn lint                # JavaScript (Standard.js)
yarn stylelint           # CSS/SCSS
```

### Assets

```bash
yarn build       # JavaScript bundle (esbuild)
yarn build:css   # Tailwind CSS build
```

## Architecture

### Key Patterns

- **Routes** are split into modular files under `config/routes/` (admin.rb, redirects.rb) and drawn from the main `config/routes.rb` via `draw(:admin)`.
- **ViewComponent** is used extensively for UI (40+ components in `app/components/`). In development, Lookbook is mounted at `/lookbook` for component previews.
- **Service objects** in `app/services/` encapsulate business logic.
- **Policies** in `app/policies/` handle authorization.
- **Adaptors** in `app/adaptors/` wrap external service integrations.
- **Builders** in `app/builders/` handle complex object creation.

### Core Domain Models

- **Path** > **Course** > **Lesson** - the curriculum hierarchy
- **User** - learners with Devise authentication
- **LessonCompletion** - tracks user progress through lessons
- **ProjectSubmission** - student project submissions (likeable, flaggable, soft-deletable via Discard)
- **Flag** - content moderation on submissions
- **AdminUser** - separate admin accounts (devise_invitable)

### Testing Conventions

- Tests use `rails_helper` (no separate `spec_helper`)
- FactoryBot factories in `spec/factories/`
- System tests use Capybara + Cuprite (headless Chrome)
- Shared examples in `spec/support/shared_examples/`
- Test order is randomized; persistence file at `spec/examples.txt`
- CI splits tests across 4 parallel containers via `bin/ci_spec`

### Code Style

- JavaScript follows Standard.js
- CSS uses Tailwind with stylelint
