# ************************
# Path - Foundations
# ************************
path = Seeds::PathBuilder.build do |path|
  path.title = 'Foundations'
  path.short_title = 'Foundations Path'
  path.description = "This is where it all begins! A hands-on introduction to all of the essential tools you'll need to build real, working websites. You'll learn what web developers actually do and the foundations you'll need for later courses."
  path.badge_uri = 'badge-foundations.svg'
  path.identifier_uuid = '33d7d165-e564-4ccd-9ac5-99b3ada05cd3'
  path.position = 1
  path.default_path = true
end

#######################
# Course - Foundations
#######################

course = path.add_course do |course|
  course.title = 'Foundations'
  course.description = "This is where it all begins! A hands-on introduction to all of the essential tools you'll need to build real, working websites. You'll learn what web developers actually do – the foundations you'll need for later courses."
  course.identifier_uuid = '783e9b72-a447-4f49-a9b3-b62826d68e04'
  course.badge_uri = 'badge-foundations.svg'
end

# +++++++++++++++++++++++++++++++
# SECTION - Introduction
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Introduction'
  section.description = 'This section will introduce you to the world of web development and The Odin Project.'
  section.identifier_uuid = '472bf0bc-2667-4206-84ea-43498b1d67f9'

  section.add_lessons(
    foundation_lessons.fetch('How This Course Will Work'),
    foundation_lessons.fetch('Introduction to Web Development'),
    foundation_lessons.fetch('Motivation and Mindset'),
    foundation_lessons.fetch('Asking For Help'),
    foundation_lessons.fetch('Join the Odin Community'),
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Prerequisites
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Prerequisites'
  section.description = 'In this section you\'ll acquire the baseline knowledge before getting into programming. Additionally, you\'ll configure your development environment and install some software necessary for web development.'
  section.identifier_uuid = 'a6ff8570-b301-4275-8cb4-1847a8f8ae25'

  section.add_lessons(
    foundation_lessons.fetch('Computer Basics'),
    foundation_lessons.fetch('How Does the Web Work?'),
    foundation_lessons.fetch('Installation Overview'),
    foundation_lessons.fetch('Installations'),
    foundation_lessons.fetch('Text Editors'),
    foundation_lessons.fetch('Command Line Basics'),
    foundation_lessons.fetch('Setting up Git'),
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Git Basics
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Git Basics'
  section.description = 'In this section you will learn the basics of Git and how you can upload your future projects to GitHub so you can share your work and collaborate with others on projects easily.'
  section.identifier_uuid = '7fbf3991-88d4-4564-9982-dce53328f037'

  section.add_lessons(
    git_lessons.fetch('Introduction to Git'),
    git_lessons.fetch('Git Basics'),
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - HTML
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'HTML Foundations'
  section.description = 'Learn the foundations of HTML, a fundamental building block of everything on the web.'
  section.identifier_uuid = '8b6abb7a-095f-4c1d-b81f-e348aaaf2894'

  section.add_lessons(
    foundation_lessons.fetch('Introduction to HTML and CSS'),
    foundation_lessons.fetch('Elements and Tags'),
    foundation_lessons.fetch('HTML Boilerplate'),
    foundation_lessons.fetch('Working with Text'),
    foundation_lessons.fetch('Lists'),
    foundation_lessons.fetch('Links and Images'),
    git_lessons.fetch('Commit Messages'),
    foundation_lessons.fetch('Recipes'),
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - CSS Basics
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'CSS Foundations'
  section.description = 'Learn how to make your HTML look the way you want by adding styles with CSS.'
  section.identifier_uuid = 'd2476929-d71b-4b25-969b-8f7da6a40c94'

  section.add_lessons(
    foundation_lessons.fetch('Intro to CSS'),
    foundation_lessons.fetch('The Cascade'),
    foundation_lessons.fetch('Inspecting HTML and CSS'),
    foundation_lessons.fetch('The Box Model'),
    foundation_lessons.fetch('Block and Inline'),
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - HTML
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Flexbox'
  section.description = 'Learn how to put things exactly where you want them on your web projects using flexbox.'
  section.identifier_uuid = '1cac0d64-f276-4999-8ff1-85d37797c312'

  section.add_lessons(
    foundation_lessons.fetch('Introduction'),
    foundation_lessons.fetch('Growing and Shrinking'),
    foundation_lessons.fetch('Axes'),
    foundation_lessons.fetch('Alignment'),
    foundation_lessons.fetch('Landing Page'),
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - JavaScript Basics
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'JavaScript Basics'
  section.description = 'Here we finally dig into JavaScript and learn how to make the web dynamic.'
  section.identifier_uuid = '331227f7-c939-4988-b8b9-e140d2ded362'

  section.add_lessons(
    foundation_lessons.fetch('Variables and Operators'),
    foundation_lessons.fetch('Installing Node.js'),
    foundation_lessons.fetch('Data Types and Conditionals'),
    foundation_lessons.fetch('JavaScript Developer Tools'),
    foundation_lessons.fetch('Function Basics'),
    foundation_lessons.fetch('Problem Solving'),
    foundation_lessons.fetch('Understanding Errors'),
    foundation_lessons.fetch('Rock Paper Scissors'),
    foundation_lessons.fetch('Clean Code'),
    foundation_lessons.fetch('Loops and Arrays'),
    foundation_lessons.fetch('DOM Manipulation and Events'),
    foundation_lessons.fetch('Revisiting Rock Paper Scissors'),
    foundation_lessons.fetch('Etch-a-Sketch'),
    foundation_lessons.fetch('Object Basics'),
    foundation_lessons.fetch('Calculator'),
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Conclusion
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Conclusion'
  section.description = "Now that you've had a healthy taste of the basics of web development, it's time to choose what specialty path you would like to take."
  section.identifier_uuid = '22cbdd2f-785b-40c9-9c54-d21755974df7'

  section.add_lessons(
    foundation_lessons.fetch('Choose Your Path Forward'),
  )
end

# clean up any removed seeds from the database
course.delete_removed_seeds
path.delete_removed_courses
