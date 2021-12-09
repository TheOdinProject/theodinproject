# *****************************
# Path - Data Analysis with Python
# *****************************
@path = Seeds::PathSeeder.create do |path|
  path.title = 'Data Analysis with Python'
  path.description = "This path takes you through our entire Data Analysis with Python curriculum. The courses should be taken in the order that they are displayed. You'll learn everything you need to know to analyze tabular data."
  path.identifier_uuid = '694d152c-b522-420a-869a-8f269c84695a'
  path.position = 4
end

load './db/fixtures/paths/data_analysis/courses/1_python.rb'

# create path prerequisites
@path.path.path_prerequisites.find_or_create_by!(prerequisite_id: Path.find_by(title: 'Foundations').id)

# clean up any removed courses
@path.delete_removed_courses
