# ************************************************
# JAVASCRIPT COURSE
# ************************************************

course = @path.courses.seed(:identifier_uuid) do |course|
  course.identifier_uuid = 'be963a26-8c2a-4af9-ac19-d68b526b5bc5'
  course.title = 'JavaScript'
  course.description = "Make your websites dynamic and interactive with JavaScript! You'll create features and stand-alone applications. This module includes projects where you will learn how to manipulate the DOM, use object-oriented programming principles, and build single page applications with React."
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
  section.identifier_uuid = 'a96a48d1-4e38-4f47-a90d-e260569c9ab5'
  section.title = 'Introduction'
  section.description = 'Welcome to the JavaScript course! Start here!'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  javascript_lessons.fetch('How this course will work').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('A quick review').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++++++++++++++++++
# SECTION - Organizing your JavaScript Code
# +++++++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'd0be5e66-0acc-4c62-8993-8d50e5af15a0'
  section.title = 'Organizing your JavaScript Code'
  section.description = 'This series digs in to the things you need to write larger and larger applications with JavaScript. This is where it gets real!'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  javascript_lessons.fetch('Organizing your JavaScript Code Introduction').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Objects and Object Constructors').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Library').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Factory Functions and the Module Pattern').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Tic Tac Toe').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Classes').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('ES6 Modules').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Restaurant Page').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('OOP Principles').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Todo List').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++++++++++++++++
# SECTION - JavaScript in the Real World
# ++++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '68a977d9-1ad5-4516-964b-c58703f19d50'
  section.title = 'JavaScript in the Real World'
  section.description = "Let's look at a few more practical applications of JavaScript and learn about a few useful tools that are widely used in the industry."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  javascript_lessons.fetch('Linting').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Dynamic User Interface Interactions').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Forms').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Webpack').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('ES?').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++++++++++++++++++++
# SECTION - Asynchronous JavaScript and APIs
# ++++++++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'c26cc657-9d04-4d12-bc2e-1c8206696da7'
  section.title = 'Asynchronous JavaScript and APIs'
  section.description = 'Asynchronous JavaScript'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  javascript_lessons.fetch('JSON').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Async').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Working with APIs').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Async and Await').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Weather App').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++
# SECTION - React JS
# ++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'bf4a29d2-6420-40bd-8e45-8f7e704a4d39'
  section.title = 'React JS'
  section.description = 'In this section you will learn the basics of the most popular frontend framework, React JS.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  react_lessons.fetch('React Introduction').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('State and Props').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('Handle Inputs and Render Lists').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('CV Application').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('Lifecycle Methods').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('Hooks').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('Memory Card').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('Router').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('Shopping Cart').merge(section_id: section.id, position: lesson_position += 1),
  react_lessons.fetch('Advanced Concepts').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++++++
# SECTION - Testing JavaScript
# ++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'c8526cf6-d66c-40f8-b03e-97c1f086d8c1'
  section.title = 'Testing JavaScript'
  section.description = "Test driven development is an important skill in today's dev world. This section digs into the details of writing automated JavaScript tests."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  javascript_lessons.fetch('Testing Basics').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Testing Practice').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('More Testing').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Battleship').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++++++++++++++
# SECTION - JavaScript and the Backend
# ++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '490be3db-7c28-43d8-a530-328a0ba8188b'
  section.title = 'JavaScript and the Backend'
  section.description = "A real web app needs a back end in order to persist its data and do sensitive operations. Here you'll learn how to use ajax to send data requests to your Rails back end or how to outsource your backend to a Backend-as-a-Service company like Firebase."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  javascript_lessons.fetch('Using Ruby on Rails or BaaS For Your Back End').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch("Where's Waldo (A Photo Tagging App)").merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++++++++++++++++++++
# SECTION - Finishing Up with JavaScript
# ++++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'd3a05406-615d-4645-85f2-0cba667f2749'
  section.title = 'Finishing Up with JavaScript'
  section.description = "You've learned everything you need and all that remains to do is apply that knowledge to a worthy task. In this section you will be working on your capstone project so you can show off your range of skills."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  javascript_lessons.fetch('Final Project').merge(section_id: section.id, position: lesson_position += 1),
  javascript_lessons.fetch('Conclusion').merge(section_id: section.id, position: lesson_position += 1),
]))

# Delete any removed seeds from the database
destroy_removed_seeds(course.lessons, seeded_lessons)
destroy_removed_seeds(course.sections, seeded_sections)

