########################
# Course - Beyond Foundations
########################
course = @path.add_course do |course|
  course.title = 'Beyond Foundations'
  course.description = "With the foundational knowledge you've learned, you're almost ready to take on the rest of the curriculum. All that's left is to get a quick introduction to the backend and then a little help in choosing your future with TOP."
  course.identifier_uuid = '7307ca83-e4cf-4789-b957-d4bdcfe3e200'
  course.show_on_homepage = true
  course.badge_uri = ''
end

# +++++++++++++
# SECTION - The Backend
# +++++++++++++
course.add_section do |section|
  section.title = 'The Backend'
  section.description = "Here you'll learn about the back end, where we'll demystify what goes on behind the scenes on a web server."
  section.identifier_uuid = '1bda637d-2590-4e0e-b988-a74605d09a8a'

  section.add_lessons(
    foundation_lessons.fetch('Introduction to the Back End'),
    foundation_lessons.fetch('Introduction to Frameworks'),
  )
end

# +++++++++++++++++++++++
# SECTION - Conclusion
# +++++++++++++++++++++++
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
