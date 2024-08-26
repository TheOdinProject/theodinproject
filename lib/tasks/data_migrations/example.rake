# create new data migration rake task file and copy the contents of this file into it
#
# namespace :data_migrations do
#
#   desc "<What will this task do?>"
#   task example_data_migration_name: :environment do
#     puts "Processing #{Lesson.count} lessons"
#
#     progressbar = ProgressBar.create(total: Lesson.count, format: '%t: |%w%i| Completed: %c %a %e')
#
#     Lesson.find_each do |lesson|
#       begin
#         # do something
#       rescue StandardError => e
#         progressbar.log "There was an error with lesson ##{lesson.id}: #{e.message}"
#       ensure
#         progressbar.increment
#       end
#     end
#   end
# end
