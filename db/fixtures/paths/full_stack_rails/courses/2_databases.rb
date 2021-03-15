# ************************************************
# DATABSES COURSE
# ************************************************

course = @path.courses.seed(:identifier_uuid) do |course|
  course.identifier_uuid = '5038bddf-c121-4e92-8c68-dd34008b7ca0'
  course.title = 'Databases'
  course.description = 'Databases are used to organize and capture large amounts of data, typically by inputting, storing, retrieving and managing the information. This course will focus on relational databases, which are widely used to store data and SQL, the language used to query the database.'
  course.position = @course_position += 1
end.first
@seeded_courses.push(course)

section_position = 0
seeded_sections = []
seeded_lessons = []

# +++++++++++++++++++
# SECTION - Databases
# +++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '2fd5cf3b-746e-442c-92b5-9871c1fc9fdb'
  section.title = 'Databases'
  section.description = 'Rails does a lot of the heavy lifting with connecting and querying a database but there will be times you need to tweak a query to the database using raw SQL. Learning how to query efficiently will help your understanding of what Rails helps abstract away.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  database_lessons.fetch('Databases').merge(section_id: section.id, position: lesson_position += 1),
  database_lessons.fetch('Databases and SQL').merge(section_id: section.id, position: lesson_position += 1),
  database_lessons.fetch('SQL').merge(section_id: section.id, position: lesson_position += 1),
]))


# Delete any removed seeds from the database
destroy_removed_seeds(course.lessons, seeded_lessons)
destroy_removed_seeds(course.sections, seeded_sections)
