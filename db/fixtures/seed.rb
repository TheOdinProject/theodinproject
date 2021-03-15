load './db/seeds/support/seed_helpers.rb'
load './db/seeds/support/path.rb'
load './db/seeds/support/course.rb'
load './db/seeds/support/section.rb'

# $seeded_paths = []
load './db/fixtures/paths/foundations/seed.rb'
# load './db/fixtures/paths/full_stack_rails/seed.rb'
# load './db/fixtures/paths/full_stack_javascript/seed.rb'

# destroy_removed_seeds(Path.all, $seeded_paths)

# module SeedsHelpers

#   def destroy_removed_seeds(persisted_collection, seeded_collection)
#     removed_uuids = persisted_collection.map(&:identifier_uuid) - seeded_collection.map(&:identifier_uuid)

#     persisted_collection.where(identifier_uuid: removed_uuids).each(&:destroy)
#   end

# end


# path = Seeds::Path.create do |path|
#   path.identifier_uuid = "ppp"
#   path.title = "A Path"
#   path.description = "a path description"
#   path.position = 1
#   path.default_path = true
# end

################
# Course - Ruby
################

# course = path.add_course do |course|
#   course.title = "A Course Title"
#   course.description = "A brand new course description"
#   course.identifier_uuid = "c"
# end


# course.add_section do |section|
#   section.title = "a section title"
#   section.description = "A brand new section title"
#   section.identifier_uuid = "ss"

#   section.add_lessons(
#     ruby_lessons.fetch("Variables"),
#     ruby_lessons.fetch("Methods"),
#   )
# end

# course.add_section do |section|
#   section.title = "another section title"
#   section.description = "A brand new section title"
#   section.identifier_uuid = "sss"

#   section.add_lessons(
#     ruby_lessons.fetch("Loops"),
#     ruby_lessons.fetch("Arrays"),
#     ruby_lessons.fetch("Hashes"),
#   )
# end

# course.delete_removed_seeds


# ###############
# # Course - Ruby
# ###############

# course = path.add_course do |course|
#   course.identifier_uuid = "cc"
#   course.title = "Another Course Title"
#   course.description = "A second brand new course description"
# end

# course.add_section do |section|
#   section.identifier_uuid = "ssss"
#   section.title = "a section title"
#   section.description = "A brand new section title"

#   section.add_lessons(
#     ruby_lessons.fetch("Variables"),
#     ruby_lessons.fetch("Methods"),
#   )
# end

# course.add_section do |section|
#   section.identifier_uuid = "sssssss"
#   section.title = "another section title"
#   section.description = "A brand new section title"

#   section.add_lessons(
#     ruby_lessons.fetch("Loops"),
#     ruby_lessons.fetch("Arrays"),
#     ruby_lessons.fetch("Hashes"),
#   )
# end


# course.delete_removed_seeds
# path.delete_removed_courses
