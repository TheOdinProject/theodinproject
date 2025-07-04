# ************************
# Path - Foundations
# ************************
path = Seeds::PathBuilder.build do |builder|
  builder.title = 'Foundations'
  builder.short_title = 'Foundations Path'
  builder.description = "This is where it all begins! A hands-on introduction to all of the essential tools you'll need to build real, working websites. You'll learn what web developers actually do and the foundations you'll need for later courses."
  builder.badge_uri = 'badge-foundations.svg'
  builder.identifier_uuid = '33d7d165-e564-4ccd-9ac5-99b3ada05cd3'
  builder.position = 1
  builder.default_path = true
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
# SECTION - Linux
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Linux'
  section.description = 'This section will introduce you to Linux fundamentals.'
  section.identifier_uuid = '472bf0bc-2667-4206-84ea-43498b1d67f9'

  section.add_lessons(
    linux_lessons.fetch('Linux in every day life'),
    linux_lessons.fetch('Ubuntu Installations'),
    linux_lessons.fetch('Filesystem navigation & more'),
    linux_lessons.fetch('File System Exercise'),
    linux_lessons.fetch('Search & archiving'),
    linux_lessons.fetch('Search & archiving exercises.'),
    linux_lessons.fetch('Linux Filesystem Permission'),
    linux_lessons.fetch('Linux Filesystem Permission Exercise'),
    linux_lessons.fetch('Installation and Maintenance'),
    linux_lessons.fetch('Installation and Maintenance Exercise'),
    linux_lessons.fetch('Desktop Customization'),
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Git
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Git'
  section.description = 'Learn how to use Git, a version control system essential for developers.'
  section.identifier_uuid = ' b63b99c0-cba2-4042-930b-bb2ab21d8366'

  section.add_lessons(
    git_lessons.fetch('why Version Control'),
    git_lessons.fetch('Getting Started'),
    git_lessons.fetch('git reset merge'),
    git_lessons.fetch('How git Store Objects'),
    git_lessons.fetch('git branching'),
    git_lessons.fetch('Colloboration using git'),
    git_lessons.fetch('Checkout Internals'),
    git_lessons.fetch('git Limitation'),
  )
end

# =======================
# Section - SQLite
# =======================
course.add_section do |section|
  section.title = 'SQLite'
  section.description = 'Learn about relational databases, SQL, and how to work with SQLite to store structured data.'
  section.identifier_uuid = '313cd021-e8c8-4f21-8edd-1b18c1f81d05'

  section.add_lessons(
    sqlite_lessons.fetch('Why Tabular and Relational'),
    sqlite_lessons.fetch('SQLite in Everyday Life'),
    sqlite_lessons.fetch('Learn SQL'),
    sqlite_lessons.fetch('Getting Started with SQLite'),
    sqlite_lessons.fetch('Exercises')
  )
end

# =======================
# Section - Docker
# =======================
course.add_section do |section|
  section.title = 'Docker'
  section.description = 'Learn the fundamentals of Docker and containerization to isolate and run your applications in any environment.'
  section.identifier_uuid = '74b5e3d6-b3a8-438e-ac70-a697f0754f37'

  section.add_lessons(
    docker_lessons.fetch('It works on My Machine'),
    docker_lessons.fetch('Runtime Isolation'),
    docker_lessons.fetch('Containerization'),
    docker_lessons.fetch('Getting Started with Docker'),
    docker_lessons.fetch('Optimizing Dockerfile'),
    docker_lessons.fetch('Docker Compose'),
    docker_lessons.fetch('Knowledge Check')
  )
end
# =======================
# Section - Cloud Computing
# =======================
course.add_section do |section|
  section.title = 'Cloud Computing'
  section.description = 'Understand how cloud infrastructure works, what services providers offer, and how to start using them.'
  section.identifier_uuid = '464de597-e107-43ab-9055-ebe77c75ca42'

  section.add_lessons(
    cloud_computing_lessons.fetch('How Internet Works'),
    cloud_computing_lessons.fetch('Hosting on Local'),
    cloud_computing_lessons.fetch('Why Cloud Computing'),
    cloud_computing_lessons.fetch('Business of Cloud Computing'),
    cloud_computing_lessons.fetch('Intro to AWS'),
    cloud_computing_lessons.fetch('S3'),
    cloud_computing_lessons.fetch('EC2 Instances & EBS'),
    cloud_computing_lessons.fetch('Billing and Cost Optimization'),
    cloud_computing_lessons.fetch('Google Cloud Clone')
  )
end

course.delete_removed_seeds
path.delete_removed_courses
