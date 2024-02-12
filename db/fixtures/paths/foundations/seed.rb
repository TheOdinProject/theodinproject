# ************************
# Path - Foundations
# ************************
@path = Seeds::PathBuilder.build do |path|
  path.title = 'Foundations'
  path.short_title = 'Foundations Path'
  path.description = "This is where it all begins! A hands-on introduction to all of the essential tools you'll need to build real, working websites. You'll learn what web developers actually do and the foundations you'll need for later courses."
  path.badge_uri = 'badge-foundations.svg'
  path.identifier_uuid = '33d7d165-e564-4ccd-9ac5-99b3ada05cd3'
  path.position = 1
  path.default_path = true
end

load './db/fixtures/paths/foundations/courses/getting_started.rb'
load './db/fixtures/paths/foundations/courses/html_css_foundations.rb'
load './db/fixtures/paths/foundations/courses/javascript_foundations.rb'
load './db/fixtures/paths/foundations/courses/beyond_foundations.rb'

# clean up any removed courses
@path.delete_removed_courses
