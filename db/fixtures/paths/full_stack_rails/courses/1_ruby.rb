# ************************************************
# RUBY COURSE
# ************************************************

course = @path.courses.seed(:identifier_uuid) do |course|
  course.identifier_uuid = '643bf355-19f1-4326-a4ad-8ec57f9ea254'
  course.title = 'Ruby Programming'
  course.description = "Time to dive deep into Ruby, the language 'designed for programmer happiness.' You'll cover object-oriented design, testing, and data structures – essential knowledge for learning other programming languages, too!"
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
  section.identifier_uuid = 'a5854f3d-8171-47d1-b53f-e325de67aca4'
  section.title = 'Introduction'
  section.description = "In this section, we'll look at the path ahead and install ruby."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('How this Course Will Work').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Installing Ruby').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++
# SECTION - Basic Ruby
# ++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'bd6d7a38-54d6-4859-b508-c4a2e1deba6b'
  section.title = 'Basic Ruby'
  section.description = "In this section, we'll cover the basic building blocks of Ruby so you have them down cold. Everything else you'll learn in programming builds on these concepts, so you'll be in a great place to take on additional projects and languages in the future."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('Basic Data Types').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Variables').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Input and Output').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Conditional Logic').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Loops').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Arrays').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Hashes').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Methods').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Basic Enumerable Methods').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Predicate Enumerable Methods').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Debugging').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++++++
# SECTION - Basic Ruby Projects
# +++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '866d62bc-4c5a-4d3f-946f-5ca2787d5bc8'
  section.title = 'Basic Ruby Projects'
  section.description = 'In this section we will solidify your basic Ruby knowledge by practicing with a few small projects.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('Caesar Cipher').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Sub Strings').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Stock Picker').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Bubble Sort').merge(section_id: section.id, position: lesson_position += 1),
]))


# ++++++++++++++++++++++++++++++++++++++++++++
# SECTION - Object Oriented Programming Basics
# ++++++++++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '0a7904f9-0824-4f32-b2b8-eedb2f47008d'
  section.title = 'Object Oriented Programming Basics'
  section.description = "You've got tools in your Ruby tool box and now it's time to combine them into more meaningful programs. In this section, you'll learn how to turn your spaghetti code into properly organized methods and classes."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('Object Oriented Programming').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Tic Tac Toe').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Mastermind').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++++++++++
# SECTION - Files and Serialization
# +++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '2222cd27-0168-4046-8b69-6921fff1764c'
  section.title = 'Files and Serialization'
  section.description = "What if you want to save the state of your program? How about loading in a file? Some basic operations like these will be covered here."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('Files and Serialization').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Event Manager').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('File I/O and Serialization').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++++++++++++
# SECTION - A Bit of Computer Science
# +++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '1dc1d088-73be-4590-9eaa-73309f614b7c'
  section.title = 'A Bit of Computer Science'
  section.description = "In this section, you'll learn some fundamental computer science concepts that will help you when solving problems with a bit more complexity than just simple web serving.  You get to try on your engineering hat and solve some pretty nifty problems."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('A Very Brief Intro to CS').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Recursive Methods').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Recursion').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Common Data Structures and Algorithms').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Linked Lists').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Binary Search Trees').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Knights Travails').merge(section_id: section.id, position: lesson_position += 1),
]))


# # +++++++++++++++++++++++++++++++++
# # SECTION - Testing Ruby with RSpec
# # +++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '1e8d5245-ed37-498e-a06e-be208aced01f'
  section.title = 'Testing Ruby with RSpec'
  section.description = "You've been briefly introduced to testing in Ruby a couple of times before in the Foundations course, but now you're going to really learn why testing can be hugely helpful and how to apply it to your own projects."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('Test Driven Development').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Introduction to RSpec').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Testing Your Ruby Code').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++
# SECTION - GIT
# +++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '4e059547-a8fd-426d-b546-24c2222106c6'
  section.title = 'GIT'
  section.description = "You should be familiar with the basic Git workflow since you've been using it to save your projects along the way (right?!).  This section will start preparing you for for the more intermediate-level uses of Git that you'll find yourself doing."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('A Deeper Look at Git').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Using Git in the Real World').merge(section_id: section.id, position: lesson_position += 1),
]))

# ++++++++++++++++++++
# SECTION - Conclusion
# ++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '42521d3c-c22e-481f-9885-9ef1156897c6'
  section.title = 'Conclusion'
  section.description = "You've come an exceptional distance already, now there's just the matter of wrapping it all together into one coherant package and creating something real. This is your Final Exam and a major feather in your cap. Once you've completed this section, you should have the confidence to tackle pretty much anything."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  ruby_lessons.fetch('Ruby Final Project').merge(section_id: section.id, position: lesson_position += 1),
  ruby_lessons.fetch('Conclusion').merge(section_id: section.id, position: lesson_position += 1),
]))


# Delete any removed seeds from the database
destroy_removed_seeds(course.lessons, seeded_lessons)
destroy_removed_seeds(course.sections, seeded_sections)
