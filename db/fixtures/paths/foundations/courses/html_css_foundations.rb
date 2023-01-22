########################
# Course - HTML and CSS Foundations
########################
course = @path.add_course do |course|
  course.title = 'HTML and CSS Foundations'
  course.description = "Before you can create anything like the websites and apps you use every day, you'll first need to know the basics of creating a simple web page. You'll learn how to build the structure of a page with HTML, add visual styling with CSS, and create a simple layout with Flexbox."
  course.identifier_uuid = 'ca6f2080-bd67-4707-988c-1e6f17e391f7'
  course.show_on_homepage = true
  course.badge_uri = 'badge-html-css.svg'
end

# +++++++++++++
# SECTION - HTML Foundations
# +++++++++++++
course.add_section do |section|
  section.title = 'HTML Foundations'
  section.description = "HTML is a fundamental building block of everything on the web. You'll learn just what HTML is and some common and useful basics."
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

# +++++++++++++++++++++++
# SECTION - CSS Foundations
# +++++++++++++++++++++++
course.add_section do |section|
  section.title = 'CSS Foundations'
  section.description = "CSS is what will help to make your HTML look the way you want. Once you complete this section, you'll be creating projects with style."
  section.identifier_uuid = 'd2476929-d71b-4b25-969b-8f7da6a40c94'

  section.add_lessons(
    foundation_lessons.fetch('CSS Foundations'),
    foundation_lessons.fetch('Inspecting HTML and CSS'),
    foundation_lessons.fetch('The Box Model'),
    foundation_lessons.fetch('Block and Inline'),
  )
end

# ++++++++++++++++++++++++++++++++++++++++++++++
# SECTION - Flexbox
# ++++++++++++++++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Flexbox'
  section.description = "Now that you've learned some styling basics, it's time to learn how to put things exactly where you want them on your web projects using flexbox, one of the most common layout methods in CSS."
  section.identifier_uuid = '1cac0d64-f276-4999-8ff1-85d37797c312'

  section.add_lessons(
    foundation_lessons.fetch('Introduction'),
    foundation_lessons.fetch('Growing and Shrinking'),
    foundation_lessons.fetch('Axes'),
    foundation_lessons.fetch('Alignment'),
    foundation_lessons.fetch('Landing Page'),
  )
end

# clean up any removed seeds from the database
course.delete_removed_seeds
