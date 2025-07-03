require './lib/seeds/path_builder'

# === Load LESSONS FIRST ===
load './db/fixtures/lessons/foundation_linux.rb'
load './db/fixtures/lessons/foundation_git.rb'
load './db/fixtures/lessons/foundation_docker.rb'
load './db/fixtures/lessons/foundation_cloud_computing.rb'
load './db/fixtures/lessons/foundation_sqlite.rb'
load './db/fixtures/lessons/python_backend.rb'

# === THEN Load PATHS ===
load './db/fixtures/paths/foundations/seed.rb'
load './db/fixtures/paths/full_stack_python/seed.rb'
# load './db/fixtures/paths/data_engineering/seed.rb'

# === Optional Additional Seeds (comment out if not used) ===
# load './db/fixtures/lessons/react_lessons.rb'
# load './db/fixtures/lessons/getting_hired_lessons.rb'
# load './db/fixtures/lessons/node_js_lessons.rb'
# load './db/fixtures/lessons/git_lessons.rb'
# load './db/fixtures/lessons/shared_lessons.rb'

Rails::Generators.invoke('seed_uuids') if Rails.env.development?
SeedFu.seed
# load './db/seeds/success_stories.rb'
# load './db/seeds/test_project_submissions.rb'
# load './db/seeds/test_users_and_admins.rb'
