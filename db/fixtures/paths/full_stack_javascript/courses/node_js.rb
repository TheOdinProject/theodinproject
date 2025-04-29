#######################
# Course - NodeJS
#######################
course = @path.add_course do |course|
  course.title = 'NodeJS'
  course.description = "Take your JavaScript skills to the server-side! Learn how to fully craft your site's backend using Express, the most popular back-end JavaScript framework! You will also learn how to use a relational database, PostgreSQL."
  course.identifier_uuid = '1a2c27d8-258a-4d9e-97a4-83a4c2a03b64'
  course.show_on_homepage = true
  course.badge_uri = 'badge-nodejs.svg'
end

# ++++++++++++++++++++++++++++++++
# SECTION = Introduction to NodeJS
# ++++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Introduction to NodeJS'
  section.description = "In this section you'll learn what NodeJS is and get your first taste of writing server-side JavaScript."
  section.identifier_uuid = 'f8ec5b6e-5f36-4164-add9-a6b1ff60e7a2'

  section.add_lessons(
    shared_lessons.fetch('Introduction to the Back End'),
    node_js_lessons.fetch('Introduction: What is NodeJS?'),
    node_js_lessons.fetch('Getting Started'),
    node_js_lessons.fetch('Debugging Node'),
    node_js_lessons.fetch('Basic Informational Site'),
    node_js_lessons.fetch('Environment Variables'),
  )
end

# +++++++++++++++++++++++++++
# SECTION - Express
# +++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Express'
  section.description = 'Here we finally get to Express, the most popular back-end JavaScript framework, and learn to build applications with a PostgreSQL database.'
  section.identifier_uuid = '3b803529-86ca-4812-8339-7f9ad6ab91cf'

  section.add_lessons(
    shared_lessons.fetch('Introduction to Frameworks'),
    node_js_lessons.fetch('Introduction to Express'),
    node_js_lessons.fetch('Routes'),
    node_js_lessons.fetch('Controllers'),
    node_js_lessons.fetch('Views'),
    node_js_lessons.fetch('Mini Message Board'),
    node_js_lessons.fetch('Deployment'),
    node_js_lessons.fetch('Forms and Data Handling'),
    node_js_lessons.fetch('Installing PostgreSQL'),
    node_js_lessons.fetch('Using PostgreSQL'),
    node_js_lessons.fetch('Inventory Application'),
  )
end

# ++++++++++++++++++++++++
# SECTION - Authentication
# ++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Authentication'
  section.description = 'We learn how to create authentication strategies that allow us to securely sign users into our applications.'
  section.identifier_uuid = '67438b44-9579-4d48-a495-ecf254479ffd'

  section.add_lessons(
    node_js_lessons.fetch('Authentication Basics'),
    node_js_lessons.fetch('Members Only'),
  )
end

# +++++++++++++++++++++++++++
# SECTION - ORMs
# +++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'ORMs'
  section.description = 'We learn about object relational mappers (ORMs) and Prisma ORM.'
  section.identifier_uuid = '5b368bc6-e85a-407f-b11d-cca313791ae2'

  section.add_lessons(
    node_js_lessons.fetch('Prisma ORM'),
    node_js_lessons.fetch('File Uploader'),
  )
end

# ++++++++++++++
# SECTION - APIs
# ++++++++++++++
course.add_section do |section|
  section.title = 'APIs'
  section.description = "We use what we've learned to create API-only backends that can serve JSON to any front-end we want."
  section.identifier_uuid = 'b94b517d-fd55-4fd2-9d54-38f6f709cfe5'

  section.add_lessons(
    node_js_lessons.fetch('API Basics'),
    node_js_lessons.fetch('API Security'),
    node_js_lessons.fetch('Blog API'),
  )
end

# +++++++++++++++++++++++++
# SECTION - Testing Express
# +++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Testing Express'
  section.description = 'In this section we learn what it takes to write tests for our Express projects.'
  section.identifier_uuid = '684b4766-6b70-451b-baa1-05760c71349f'

  section.add_lessons(
    node_js_lessons.fetch('Testing Routes and Controllers'),
    node_js_lessons.fetch('Testing Database Operations'),
  )
end

# +++++++++++++++++++++++++
# SECTION - Full Stack Projects
# +++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Full Stack Projects'
  section.description = 'Full Stack Projects'
  section.identifier_uuid = '4e08c6d2-e0ad-4e3c-812b-ae793cc6bfd8'

  section.add_lessons(
    react_lessons.fetch('Where\'s Waldo (A Photo Tagging App)'),
    react_lessons.fetch('Messaging App'),
  )
end

# +++++++++++++++++++++++
# SECTION - FINAL PROJECT
# +++++++++++++++++++++++
course.add_section do |section|
  section.title = 'FINAL PROJECT'
  section.description = "This is it! Create your final project and prove to the world you're a node/express master."
  section.identifier_uuid = '941fbec9-aeca-4cad-96fb-da60035b4a27'

  section.add_lessons(
    node_js_lessons.fetch('Odin-Book'),
    node_js_lessons.fetch('Conclusion'),
  )
end

# clean up any removed seeds from the database
course.delete_removed_seeds
