# === Load LESSONS ===
load './db/fixtures/lessons/foundation_linux.rb'
load './db/fixtures/lessons/foundation_git.rb'
load './db/fixtures/lessons/foundation_docker.rb'
load './db/fixtures/lessons/foundation_cloud_computing.rb'
load './db/fixtures/lessons/foundation_sqlite.rb'
load './db/fixtures/lessons/python_backend.rb'

# === Generate UUIDs for dev only ===
Rails::Generators.invoke('seed_uuids') if Rails.env.development?

# === SeedFu Fixtures ===
SeedFu.seed
