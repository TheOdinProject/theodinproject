# load all lessons
load './db/fixtures/lessons/foundation_lessons.rb'
load './db/fixtures/lessons/ruby_lessons.rb'
load './db/fixtures/lessons/database_lessons.rb'
load './db/fixtures/lessons/ruby_on_rails_lessons.rb'
load './db/fixtures/lessons/html_and_css_lessons.rb'
load './db/fixtures/lessons/javascript_lessons.rb'
load './db/fixtures/lessons/react_lessons.rb'
load './db/fixtures/lessons/getting_hired_lessons.rb'
load './db/fixtures/lessons/node_js_lessons.rb'
load './db/fixtures/lessons/git_lessons.rb'
load './db/fixtures/lessons/shared_lessons.rb'

require_relative '../lib/generators/rails/seed_uuids/seed_uuids_generator'
Rails::Generators.invoke('seed_uuids') if Rails.env.development?
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
