@path = Path.seed(:identifier_uuid) do |path|
  path.identifier_uuid = '16109529-1526-4800-be11-0f655bcfb4cc'
  path.title = 'Full Stack Ruby on Rails'
  path.description = "This path takes you through our entire Ruby on Rails curriculum. You'll learn everything you need to know to create beautiful responsive websites from scratch."
  path.position = 2
end.first
$seeded_paths.push(@path)

# create the courses for the path
@course_position = 0
@seeded_courses = []
load './db/fixtures/paths/full_stack_rails/courses/1_ruby.rb'
load './db/fixtures/paths/full_stack_rails/courses/2_databases.rb'
load './db/fixtures/paths/full_stack_rails/courses/3_rails.rb'
load './db/fixtures/paths/full_stack_rails/courses/4_html_and_css.rb'
load './db/fixtures/paths/full_stack_rails/courses/5_javascript.rb'
load './db/fixtures/paths/full_stack_rails/courses/6_getting_hired.rb'

# delete any courses that been removed from the seeds in the database
destroy_removed_seeds(@path.courses, @seeded_courses)


