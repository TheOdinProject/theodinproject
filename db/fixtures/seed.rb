require './lib/seeds/path_builder'

# load paths
load './db/fixtures/paths/foundations/seed.rb'
load './db/fixtures/paths/full_stack_python/seed.rb'
load './db/fixtures/paths/data_engineering/seed.rb'

# in db/seeds.rb
load './db/fixtures/lessons/foundation_linux.rb' # or similar
load './db/fixtures/lessons/foundation_git.rb' # or similar
