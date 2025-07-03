
# ************************
# Path - Full Stack Python
# ************************
path = Seeds::PathBuilder.build do |builder|
  builder.title = 'Full Stack Python'
  builder.short_title = 'Full Stack Python'
  builder.description = 'Learn how to build robust backends using Python. Start with the language fundamentals and grow into advanced topics like FastAPI.'
  builder.identifier_uuid = 'd3cfe251-f120-4829-aa63-5b4d7fd6b65a'
  builder.position = 2
  builder.badge_uri = 'badge-full-stack-python.svg'
end

# ************************
# Course - Python Backend
# ************************
course = path.add_course do |course|
  course.title = 'Python Backend'
  course.description = 'Master Python for web development using FastAPI. This course walks through everything from core concepts to deploying real-world applications.'
  course.identifier_uuid = '3694084a-5e58-452d-b99e-679c1a477925'
  course.badge_uri = 'badge-foundations.svg'
end

# ===========================
# SECTION - Python Basics
# ===========================
course.add_section do |section|
  section.title = 'Python Basics'
  section.description = 'Core Python concepts to get started building real applications.'
  section.identifier_uuid = '11d7101b-6c19-4c56-af15-72cc2fb28fdf'

  section.add_lessons(
    $python_backend_lessons.fetch('Inside Python'),
    $python_backend_lessons.fetch('Hands Behind Python'),
    $python_backend_lessons.fetch('Python Toolbox'),
    $python_backend_lessons.fetch('Python Getting Started'),
    $python_backend_lessons.fetch('Level Up Python Exercises'),
    $python_backend_lessons.fetch('Testing with unittest, mock, fixture'),
    $python_backend_lessons.fetch('Python Project'),
    $python_backend_lessons.fetch('MVT & Jinja Templating'),
    $python_backend_lessons.fetch('Django')
  )
end

# ===========================
# SECTION - FastAPI
# ===========================
course.add_section do |section|
  section.title = 'FastAPI'
  section.description = 'Learn how to build modern, high-performance APIs using FastAPI.'
  section.identifier_uuid = 'eab9dff2-fe10-45d0-9002-596ed9713b43' # Replace with real UUID

  section.add_lessons(
    $python_backend_lessons.fetch('Fast API kickoff'),
    $python_backend_lessons.fetch('Basic API Features'),
    $python_backend_lessons.fetch('Database Integration'),
    $python_backend_lessons.fetch('Advanced Features'),
    $python_backend_lessons.fetch('Testing and Deployment Capstone')
  )
end

course.delete_removed_seeds
path.delete_removed_courses
