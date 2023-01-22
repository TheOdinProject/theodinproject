########################
# Course - JavaScript Foundations
########################
course = @path.add_course do |course|
  course.title = 'JavaScript Foundations'
  course.description = "Now it's time to implement some actual functionality. You'll learn the basics to writing JavaScript code, how to debug and plan out your code, and how to dynamically update a page."
  course.identifier_uuid = 'ace112b1-0407-454e-9d23-da2099554a42'
  course.show_on_homepage = true
  course.badge_uri = 'badge-javascript.svg'
end

# +++++++++++++
# SECTION - JavaScript Basics
# +++++++++++++
course.add_section do |section|
  section.title = 'JavaScript Basics'
  section.description = "Here we finally dig into JavaScript and learn how to make the web dynamic."
  section.identifier_uuid = '331227f7-c939-4988-b8b9-e140d2ded362'

  section.add_lessons(
    foundation_lessons.fetch('Fundamentals Part 1'),
    foundation_lessons.fetch('Fundamentals Part 2'),
    foundation_lessons.fetch('JavaScript Developer Tools'),
    foundation_lessons.fetch('Fundamentals Part 3'),
    foundation_lessons.fetch('Problem Solving'),
    foundation_lessons.fetch('Understanding Errors'),
    foundation_lessons.fetch('Rock Paper Scissors'),
    foundation_lessons.fetch('Clean Code'),
    foundation_lessons.fetch('Installing Node.js'),
    foundation_lessons.fetch('Fundamentals Part 4'),
    foundation_lessons.fetch('DOM Manipulation and Events'),
    foundation_lessons.fetch('Revisiting Rock Paper Scissors'),
    foundation_lessons.fetch('Etch-a-Sketch'),
    foundation_lessons.fetch('Fundamentals Part 5'),
    foundation_lessons.fetch('Calculator'),
  )
end

# clean up any removed seeds from the database
course.delete_removed_seeds
