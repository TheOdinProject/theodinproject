########################
# Course - React
########################
course = @path.add_course do |course|
  course.title = 'React'
  course.description = 'Let\'s learn React, the most popular JavaScript library for building user interfaces. Take your frontend skills to a whole new level!'
  course.identifier_uuid = 'f1dffa59-de01-4706-ba26-1e480067d19d'
  course.show_on_homepage = true
  course.badge_uri = 'badge-react.svg'
end

# ++++++++++++++++++++++
# SECTION - Introduction
# ++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Introduction'
  section.description = 'Introduction'
  section.identifier_uuid = 'd42546a1-7a58-4b01-96b6-1e62d723f302'

  section.add_lessons(
    react_lessons.fetch('How This Course Will Work'),
    react_lessons.fetch('Introduction To React'),
    react_lessons.fetch('Setting Up A React Environment'),
  )
end

# +++++++++++++++++++++++++++++++++++++++++
# SECTION - Getting Started With React
# +++++++++++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Getting Started With React'
  section.description = 'Getting Started With React'
  section.identifier_uuid = 'dfd21927-cbc9-4398-9008-7c63b603a507'

  section.add_lessons(
    react_lessons.fetch('React Components'),
    react_lessons.fetch('What Is JSX?'),
    react_lessons.fetch('Rendering Techniques'),
    react_lessons.fetch('Keys In React'),
    react_lessons.fetch('Passing Data Between Components'),
  )
end

# ++++++++++++++++++++++++++++++++++++++
# SECTION - States And Effects
# ++++++++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'States And Effects'
  section.description = 'States And Effects'
  section.identifier_uuid = 'ae0941e5-9f9b-4324-befb-4e88da89015a'

  section.add_lessons(
    react_lessons.fetch('Introduction To State'),
    react_lessons.fetch('More On State'),
    react_lessons.fetch('CV Application'),
    react_lessons.fetch('How To Deal With Side Effects'),
    react_lessons.fetch('Memory Card'),
  )
end

# ++++++++++++++++++++++++++++++++++++++++++
# SECTION - Class Components
# ++++++++++++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Class Components'
  section.description = 'Class Components'
  section.identifier_uuid = '2b8ef391-6170-4d52-9476-b88d1b2f30b6'

  section.add_lessons(
    react_lessons.fetch('Class Based Components'),
    react_lessons.fetch('Component Lifecycle Methods'),
  )
end

# ++++++++++++++++++++++++++++++++++++++++++
# SECTION - React Testing
# ++++++++++++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'React Testing'
  section.description = 'React Testing'
  section.identifier_uuid = '13f76093-ca43-4443-b63c-e266d30a4c0d'

  section.add_lessons(
    react_lessons.fetch('Introduction To React Testing'),
    react_lessons.fetch('Mocking Callbacks And Components')
  )
end

# ++++++++++++++++++++++++++++
# SECTION - The React Ecosystem
# ++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'The React Ecosystem'
  section.description = 'The React Ecosystem'
  section.identifier_uuid = '8d644340-1fde-40bd-8a86-a967d5baf6bc'

  section.add_lessons(
    react_lessons.fetch('Type Checking With PropTypes'),
    react_lessons.fetch('React Router'),
    react_lessons.fetch('Fetching Data In React'),
    react_lessons.fetch('Styling React Applications'),
    react_lessons.fetch('Shopping Cart'),
  )
end

# +++++++++++++
# SECTION - More React Concepts
# +++++++++++++
course.add_section do |section|
  section.title = 'More React Concepts'
  section.description = 'More React Concepts'
  section.identifier_uuid = '39a35116-8d27-4058-a4f5-d08b71320030'

  section.add_lessons(
    react_lessons.fetch('Managing State With The Context API'),
    react_lessons.fetch('Reducing State'),
    react_lessons.fetch('Refs And Memoization'),
  )
end

# ++++++++++++++++++++++++++++++++++++
# SECTION - Conclusion
# ++++++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Conclusion'
  section.description = 'Conclusion'
  section.identifier_uuid = '9232bdc3-cd02-4f24-b516-fca708b5198b'

  section.add_lessons(
    react_lessons.fetch('Conclusion (Node Path)'),
  )
end

# clean up any removed seeds from the database
course.delete_removed_seeds
