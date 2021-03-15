# ************************************************
# FOUNDATIONS COURSE
# ************************************************

course = @path.courses.seed(:identifier_uuid) do |course|
  course.identifier_uuid = '783e9b72-a447-4f49-a9b3-b62826d68e04'
  course.title = 'Foundations'
  course.description = "This is where it all begins! A hands-on introduction to all of the essential tools you'll need to build real, working websites. You'll learn what web developers actually do – the foundations you'll need for later courses."
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
  section.identifier_uuid = '472bf0bc-2667-4206-84ea-43498b1d67f9'
  section.title = 'Introduction'
  section.description = "This section will cover the baseline knowledge you need before getting into the more 'programming' aspects of web development."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  foundation_lessons.fetch('How this Course Will Work').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Introduction to Web Development').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Motivation and Mindset').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Join the Odin Community').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('How Does the Web Work?').merge(section_id: section.id, position: lesson_position += 1),
]))


# +++++++++++++++++++++++
# SECTION - Installations
# +++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = 'a6ff8570-b301-4275-8cb4-1847a8f8ae25'
  section.title = 'Installations'
  section.description = 'In this section you will configure your development environment and install some software necessary for web development.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  foundation_lessons.fetch('Installation Overview').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Prerequisites').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Text Editors').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Command Line Basics').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Setting Up Git').merge(section_id: section.id, position: lesson_position += 1),
]))


# ++++++++++++++++++++
# SECTION - Git Basics
# ++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '7fbf3991-88d4-4564-9982-dce53328f037'
  section.title = 'Git Basics'
  section.description = 'In this section you will learn the basics of Git and how you can upload your future projects to GitHub so you can share your work and collaborate with others on projects easily.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  foundation_lessons.fetch('Introduction to Git').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Git Basics').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Practicing Git Basics').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++
# SECTION - The Front End
# +++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '552d3718-14c6-4b0a-848d-2dcca271ac61'
  section.title = 'The Front End'
  section.description = "In this section you'll spend a good deal of time getting familiar with the major client-side (browser-based) languages like HTML, CSS, and JavaScript. You'll get to build a webpage with HTML/CSS and learn some programming fundamentals with JavaScript."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  foundation_lessons.fetch('Introduction to the Front End').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('HTML and CSS Basics').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Developer Tools').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Google Homepage').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++++
# SECTION = JavaScript Basics
# +++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '331227f7-c939-4988-b8b9-e140d2ded362'
  section.title = 'JavaScript Basics'
  section.description = 'Here we finally dig into JavaScript and learn how to make the web dynamic.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  foundation_lessons.fetch('Fundamentals Part 1').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Fundamentals Part 2').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Developer Tools 2').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Fundamentals Part 3').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Problem Solving').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Rock Paper Scissors').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Clean Code').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Fundamentals Part 4').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('DOM manipulation').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Etch-a-Sketch').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Fundamentals Part 5').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Calculator').merge(section_id: section.id, position: lesson_position += 1),
]))
seeded_sections.push(section)

# ++++++++++++++++++++++
# SECTION - The Back End
# ++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '1bda637d-2590-4e0e-b988-a74605d09a8a'
  section.title = 'The Back End'
  section.description = "Here you'll learn about the back end, where we'll demystify what goes on behind the scenes on a web server."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  foundation_lessons.fetch('Introduction to the Back End').merge(section_id: section.id, position: lesson_position += 1),
  foundation_lessons.fetch('Introduction to Frameworks').merge(section_id: section.id, position: lesson_position += 1),
]))


# +++++++++++++++++++++++++++++++
# SECTION - Tying it All Together
# +++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '22cbdd2f-785b-40c9-9c54-d21755974df7'
  section.title = 'Tying it All Together Maybe'
  section.description = "Now that you've had a healthy taste of all the major components in a web application, we'll take a step back and remember where they all fit into the bigger picture."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  foundation_lessons.fetch('Conclusion').merge(section_id: section.id, position: lesson_position += 1),
]))

destroy_removed_seeds(course.lessons, seeded_lessons)
destroy_removed_seeds(course.sections, seeded_sections)
