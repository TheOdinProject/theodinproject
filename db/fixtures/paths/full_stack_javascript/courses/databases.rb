#######################
# Course - Databases
#######################
course = @path.add_course do |course|
  course.title = 'Databases'
  course.description = 'Databases are used to organize and capture large amounts of data, typically by inputting, storing, retrieving and managing the information. This course will focus on relational databases, which are widely used to store data and SQL, the language used to query the database.'
  course.identifier_uuid = '8179728b-8401-4653-9839-5843c99cad7d'
  course.badge_uri = 'badge-database.svg'
end

# +++++++++++++++++++
# SECTION - Databases
# +++++++++++++++++++
course.add_section do |section|
  section.title = 'Databases'
  section.description = 'When working with databases, there may be situations where you need to directly interact with the database using raw SQL queries. Learning SQL will enable you to effectively manipulate and retrieve data from the database.'
  section.identifier_uuid = '81f416b2-a0d0-4363-b9c1-341de3a685c1'

  section.add_lessons(
    database_lessons.fetch('Databases'),
    database_lessons.fetch('Databases and SQL'),
    database_lessons.fetch('SQL Zoo'),
  )
end

# clean up any removed seeds from the database
course.delete_removed_seeds
