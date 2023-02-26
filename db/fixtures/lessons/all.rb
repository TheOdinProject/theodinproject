require './lib/seeds/helpers'
include Seeds::Helpers

def build_lesson(attributes)
  Lesson.seed(:identifier_uuid) do |lesson|
    lesson.identifier_uuid = attributes.fetch(:identifier_uuid)
    lesson.title = attributes.fetch(:title)
    lesson.description = attributes.fetch(:description)
    lesson.github_path = attributes.fetch(:github_path)
    lesson.is_project = attributes.fetch(:is_project, false)
    lesson.accepts_submission = attributes.fetch(:accepts_submission, false)
    lesson.choose_path_lesson = attributes.fetch(:choose_path_lesson, false)
    lesson.installation_lesson = attributes.fetch(:installation_lesson, false)
  end.first
end

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

# Remove any lessons that have been removed from the seed files
destroy_removed_seeds(persisted_collection: Lesson.all, seeded_collection: foundation_lessons.values)
