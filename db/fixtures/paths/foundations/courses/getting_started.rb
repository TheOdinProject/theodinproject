########################
# Course - Getting Started
########################
course = @path.add_course do |course|
  course.title = 'Getting Started'
  course.description = "Whether you're experienced in programming or totally new to it, this is where everyone should start with The Odin Project. You'll learn about the mindset and conduct one needs to be a successful professional, some required installations for doing this curriculum, and some of the workflow habits you'll use throughout the curriculum and beyond."
  course.identifier_uuid = '6eb953fc-de6f-4b00-ac1f-dfd0b438814e'
  course.show_on_homepage = true
  course.badge_uri = 'badge-foundations.svg'
end

# +++++++++++++
# SECTION - Introduction
# +++++++++++++
course.add_section do |section|
  section.title = 'Introduction'
  section.description = "In this introduction to The Odin Project you'll learn how you can be most successful when going through the curriculum, from improving your mindset when it comes to learning to seeking help from other users."
  section.identifier_uuid = '472bf0bc-2667-4206-84ea-43498b1d67f9'

  section.add_lessons(
    foundation_lessons.fetch('How This Course Will Work'),
    foundation_lessons.fetch('Introduction to Web Development'),
    foundation_lessons.fetch('Motivation and Mindset'),
    foundation_lessons.fetch('Asking For Help'),
    foundation_lessons.fetch('Join the Odin Community'),
  )
end

# +++++++++++++++++++++++
# SECTION - Prerequisites
# +++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Prerequisites'
  section.description = "In this section you'll first acquire some baseline knowledge related to computers and the web. Then you'll configure some of the necessary installations for the entire curriculum."
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

# ++++++++++++++++++++++++++++++++++++++++++++++
# SECTION - Git Basics
# ++++++++++++++++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Git Basics'
  section.description = "It's time to Git good! You'll learn the basics of Git and how you can upload your projects to GitHub. This will set you up to share your work with other users and future employers, as well as collaborate with others on projects."
  section.identifier_uuid = '7fbf3991-88d4-4564-9982-dce53328f037'

  section.add_lessons(
    git_lessons.fetch('Introduction to Git'),
    git_lessons.fetch('Git Basics'),
  )
end

# clean up any removed seeds from the database
course.delete_removed_seeds
