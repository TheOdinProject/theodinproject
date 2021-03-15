# ************************************************
# RAILS COURSE
# ************************************************

course = @path.courses.seed(:identifier_uuid) do |course|
  course.identifier_uuid = '100c8fbd-8cb0-4bdf-a809-66ecd69ec885'
  course.title = 'Ruby on Rails'
  course.description = "Take Ruby to the next level with the Ruby on Rails framework! Learn how to fully craft your site's backend using the Model-View-Controller design pattern. You'll gain the confidence to launch a website in under an hour."
  course.position = @course_position += 1
end.first
@seeded_courses.push(course)

section_position = 0
seeded_sections = []
seeded_lessons = []

# ++++++++++++++++++++++
# SECTION - Introduction
# ++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'e8d47281-55b2-4cc1-9679-a46d99fa2287'
  section.title = 'Introduction'
  section.description = 'In this section, we will install Rails.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_on_rails_lessons.fetch('How this Course Will Work').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Preparing for Deployment').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Installing Rails').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++
# SECTION - Rails Basics
# ++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '8ffa853e-e5d0-44d8-a61c-4a620601c422'
  section.title = 'Rails Basics'
  section.description = "It's time to start looking carefully into the foundational pieces of the Rails framework. We'll cover the path of an HTTP request from entering your application to returning as an HTML page to the browser."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_on_rails_lessons.fetch('A Railsy Web Refresher').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Routing').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Controllers').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Views').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('The Asset Pipeline').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Webpacker').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Deployment').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Blog App').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++++++++
# SECTION - Active Record Basics
# ++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '0f07a836-ba21-472e-b2e5-82803862b1ae'
  section.title = 'Active Record Basics'
  section.description = "This section covers the back end of Rails, which is the most important part of the framework. You'll learn how to interface with databases using the fantastic Active Record gem."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_on_rails_lessons.fetch('Active Record Basics').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Building With Active Record').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++++++++++++
# SECTION - Forms and Authentication
# ++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '4cfbfcf7-f561-4e63-8bcd-050175684aba'
  section.title = 'Forms and Authentication'
  section.description = "This section gets into some of the areas of web apps that are less glamorous than they are important.  Forms are your user's window to interact with your application. Authentication is critical for many applications, and you'll build a couple of auth systems from the ground up."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_on_rails_lessons.fetch('Form Basics').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Forms').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Sessions, Cookies and Authentication').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Authentication').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++++++++++++++++++++
# SECTION - Advanced Forms and Active Record
# ++++++++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'd391a4d0-8aa2-4eb0-bd58-2395ba3f837c'
  section.title = 'Advanced Forms and Active Record'
  section.description = "Now it's starting to get fun! Learn how to do more than just find and show your users... you'll learn how to use relationships between models to greatly expand your abilities and how to build web forms with sufficient firepower to achieve your most ambitious goals."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_on_rails_lessons.fetch('Active Record Queries').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Active Record Associations').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Associations').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Active Record Callbacks').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Advanced Forms').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Building Advanced Forms').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++
# SECTION - APIs
# ++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '0e7e7a73-8d9c-484f-8339-e63125ae89d3'
  section.title = 'APIs'
  section.description = 'In this penultimate section we will explore harnessing the powers of other apps via their APIs and creating our own.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_on_rails_lessons.fetch('APIs and Building Your Own').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Working With External APIs').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Kittens API').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Using an API').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++++++++++++++
# SECTION - Mailers and Advanced Topics
# +++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'dc9c8e4c-f3e9-4536-81be-c4dc51f66dff'
  section.title = 'Mailers and Advanced Topics'
  section.description = 'This final section will take you into some of the more interesting sides of the Rails ecosystem which will help you reach beyond your own app and into the lives of your users via email.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_on_rails_lessons.fetch('Mailers').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Sending Confirmation Emails').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Advanced Topics').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Websockets and Actioncable').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Final Project').merge(section_id: section.id, position: lesson_position += 1),
  ruby_on_rails_lessons.fetch('Conclusion').merge(section_id: section.id, position: lesson_position += 1),
]))


# Delete any removed seeds from the database
destroy_removed_seeds(course.lessons, seeded_lessons)
destroy_removed_seeds(course.sections, seeded_sections)
