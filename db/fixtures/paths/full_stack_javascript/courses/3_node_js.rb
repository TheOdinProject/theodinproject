# ************************************************
# NODE JS COURSE
# ************************************************

course = @path.courses.seed(:identifier_uuid) do |course|
  course.identifier_uuid = '1a2c27d8-258a-4d9e-97a4-83a4c2a03b64'
  course.title = 'NodeJS'
  course.description = "Take your JavaScript skills to the server-side! Learn how to fully craft your site's backend using Express, the most popular back-end JavaScript framework! You will also learn how to use a non-relational database, MongoDB."
  course.position = @course_position += 1
end.first
@seeded_courses.push(course)

section_position = 0
seeded_sections = []
seeded_lessons = []

# ++++++++++++++++++++++++++++++++
# SECTION = Introduction to NodeJS
# ++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'f8ec5b6e-5f36-4164-add9-a6b1ff60e7a2'
  section.title = 'Introduction to NodeJS'
  section.description = "In this section you'll learn what NodeJS is and get your first taste of writing server-side JavaScript."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  node_js_lessons.fetch('Introduction: What is NodeJs').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Getting Started').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Basic Informational Site').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++++
# SECTION - Express & MongoDB
# +++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '667788c1-67b9-4ed1-9b72-c5e8bc6f9009'
  section.title = 'Express & MongoDB'
  section.description = 'Here we finally get to Express, the most popular back-end JavaScript framework, and MongoDB, a non-relational database frequently paired with Node.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  node_js_lessons.fetch('Introduction to Express').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Express 101').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Express 102: CRUD and MVC').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Preparing for Deployment').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Mini Message Board').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Express 103: Routes and Controllers').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Express 104: View Templates').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Express 105: Forms and Deployment').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Inventory Application').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++
# SECTION - Authentication
# ++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '67438b44-9579-4d48-a495-ecf254479ffd'
  section.title = 'Authentication'
  section.description = 'We learn how to create authentication strategies that allow us to securely sign users into our applications.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  node_js_lessons.fetch('Authentication Basics').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Security Configuration').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Members Only').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++
# SECTION - APIs
# ++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'b94b517d-fd55-4fd2-9d54-38f6f709cfe5'
  section.title = 'APIs'
  section.description = "We use what we've learned to create API-only backends that can serve JSON to any front-end we want."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  node_js_lessons.fetch('API basics').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('API Security').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Blog API').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++
# SECTION - Testing Express
# +++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '684b4766-6b70-451b-baa1-05760c71349f'
  section.title = 'Testing Express'
  section.description = 'In this section we learn what it takes to write tests for our Express projects.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  node_js_lessons.fetch('Testing Routes and Controllers').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Testing database operations').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++
# SECTION - FINAL PROJECT
# +++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '941fbec9-aeca-4cad-96fb-da60035b4a27'
  section.title = 'FINAL PROJECT'
  section.description = "This is it! Create your final project and prove to the world you're a node/express master."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  node_js_lessons.fetch('Odin-Book').merge(section_id: section.id, position: lesson_position += 1),
  node_js_lessons.fetch('Conclusion').merge(section_id: section.id, position: lesson_position += 1),
]))

# Delete any removed seeds from the database
destroy_removed_seeds(course.lessons, seeded_lessons)
destroy_removed_seeds(course.sections, seeded_sections)
