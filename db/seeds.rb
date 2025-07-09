# === Load LESSONS ===
load './db/fixtures/lessons/foundation_linux.rb'
load './db/fixtures/lessons/foundation_git.rb'
load './db/fixtures/lessons/foundation_docker.rb'
load './db/fixtures/lessons/foundation_cloud_computing.rb'
load './db/fixtures/lessons/foundation_sqlite.rb'
load './db/fixtures/lessons/python_backend.rb'
load './db/fixtures/lessons/data_engineering.rb'

# === Generate UUIDs for dev only ===
Rails::Generators.invoke('seed_uuids') if Rails.env.development?

# === SeedFu Fixtures ===
SeedFu.seed

# GENERATE SUCCESS STORY Content
load './db/seeds/success_stories.rb'

# GENERATE test projects
load './db/seeds/test_project_submissions.rb'

# GENERATE users and admin users for testing
load './db/seeds/test_users_and_admins.rb'

# GENERATE course lesson and project counts
load './db/seeds/update_course_counts.rb'

# ADDS new feature flags to Flipper
load './db/seeds/feature_flags.rb'
