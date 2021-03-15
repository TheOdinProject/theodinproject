@path = Path.seed(:identifier_uuid) do |path|
  path.identifier_uuid = '624d152c-b522-4f7a-86aa-8f2d9c84b951'
  path.title = 'Full Stack JavaScript'
  path.description = "This path takes you through our entire JavaScript curriculum. You'll learn everything you need to know to create beautiful responsive websites from scratch using JavaScript and NodeJs."
  path.position = 3
end.first
$seeded_paths.push(@path)

# create the courses for the path
@course_position = 0
@seeded_courses = []
load './db/fixtures/paths/full_stack_javascript/courses/1_javascript.rb'
load './db/fixtures/paths/full_stack_javascript/courses/2_html_and_css.rb'
load './db/fixtures/paths/full_stack_javascript/courses/3_node_js.rb'
load './db/fixtures/paths/full_stack_javascript/courses/4_getting_hired.rb'

# delete any courses that been removed from the seeds in the database
destroy_removed_seeds(@path.courses, @seeded_courses)
