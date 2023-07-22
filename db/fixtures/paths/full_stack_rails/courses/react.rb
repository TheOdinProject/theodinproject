########################
# Course - React
########################
course = @path.add_course do |course|
  course.title = 'React'
  course.description = 'Let\'s learn React, the most popular JavaScript library for building user interfaces. Take your frontend skills to a whole new level!'
  course.identifier_uuid = '86fc2405-4623-41d5-9518-4a82511d12c0'
  course.show_on_homepage = false
  course.badge_uri = 'badge-react.svg'
end

# ++++++++++++++++++++++
# SECTION - Introduction
# ++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Introduction'
  section.description = 'Introduction'
  section.identifier_uuid = 'b69220bd-ef5e-4b76-9c39-2ef9baf99c61'

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
  section.identifier_uuid = 'b45d1321-ab85-4069-8c83-ee6ec73b0a2f'

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
  section.identifier_uuid = '2365dead-8806-40e9-90a1-bf14ed9aa354'

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
  section.identifier_uuid = '34029ff3-b0a3-4964-a199-a4f1f55b07c1'

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
  section.identifier_uuid = '3f7f8eea-9f71-4ab0-87ae-d27ad15935f4'

  section.add_lessons(
    react_lessons.fetch('Introduction To React Testing'),
    react_lessons.fetch('Mocking Callbacks And Components')
  )
end

# ++++++++++++++++++++++++++++
# SECTION - The React Ecocsystem
# ++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'The React Ecocsystem'
  section.description = 'The React Ecocsystem'
  section.identifier_uuid = 'ee3b2ee1-8ced-4ce5-a939-90bb9a47694d'

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
  section.identifier_uuid = 'd2256a4c-f477-49db-a847-98d881ccc53b'

  section.add_lessons(
    react_lessons.fetch('Managing State With The Context API'),
    react_lessons.fetch('Reducing State'),
    react_lessons.fetch('Refs And Memoization'),
  )
end

# ++++++++++++++++++
# SECTION - React And The Backend
# ++++++++++++++++++
course.add_section do |section|
  section.title = 'React And The Backend'
  section.description = 'React And The Backend'
  section.identifier_uuid = '93c2e2c8-9719-4524-b85b-908a0a76f794'

  section.add_lessons(
    react_lessons.fetch('Using Ruby On Rails For Your Backend'),
    react_lessons.fetch('Where\'s Waldo (A Photo Tagging App)'),
    react_lessons.fetch('Messaging App'),
  )
end

# ++++++++++++++++++++++++++++++++++++
# SECTION - Conclusion
# ++++++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Conclusion'
  section.description = 'Concolusion'
  section.identifier_uuid = 'e6d0949d-075d-48f6-8d7f-ab066f720cdd'

  section.add_lessons(
    react_lessons.fetch('Conclusion'),
  )
end

# clean up any removed seeds from the database
course.delete_removed_seeds
