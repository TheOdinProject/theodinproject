# ************************************************
# GETTING HIRED COURSE
# ************************************************

course = @path.courses.seed(:identifier_uuid) do |course|
  course.identifier_uuid = 'fdad8aa6-d77c-4e7f-9d83-130e838904f3'
  course.title = 'Getting Hired'
  course.description = "Web development is a lifelong journey of learning and growth. Continue that journey on a professional development team! You'll learn where to find jobs, how to do great interviews, and the best strategies to launch your career."
  course.position = @course_position += 1
end.first
@seeded_courses.push(course)

section_position = 0
seeded_sections = []
seeded_lessons = []

# +++++++++++++++++++++++++++++++++++++++
# SECTION - Preparing for Your Job Search
# +++++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '5253b457-47e4-401c-81d0-92cd7817f138'
  section.title = 'Preparing for Your Job Search'
  section.description = 'Your job search begins long before you send out the first application, so be sure to adequately prepare by laying out a strategy and being honest with yourself about your goals, needs and expectations.'
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  getting_hired_lessons.fetch('How This Course Will Work').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('Strategy').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('It Starts with YOU').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('What Companies Want').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('What You Can Do To Prepare').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('Building Your Personal Website').merge(section_id: section.id, position: lesson_position += 1),
]))

# +++++++++++++++++++++++++++++++++++++++++++++++
# SECTION - Applying to and Interviewing for Jobs
# +++++++++++++++++++++++++++++++++++++++++++++++

section = course.sections.seed(:identifier_uuid) do |section|
  section.identifier_uuid = '8b579b0b-e394-4959-b86e-ab7e92d1b1b3'
  section.title = 'Applying to and Interviewing for Jobs'
  section.description = "This is an odds game, so you've got to structure your plan and focus on highest probability approaches and targets. In this section we'll cover how the process typically works and the best way to increase your odds of success. Go get 'em."
  section.position = section_position += 1
end.first
seeded_sections.push(section)

lesson_position = 0
seeded_lessons.concat(section.lessons.seed(:identifier_uuid, :section_id, [
  getting_hired_lessons.fetch('Collecting Job Leads').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('Qualifying Job Leads').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('Building Your Resume').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('Applying for Web Development Jobs').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('Preparing to Interview and Interviewing').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('Handling a Job Offer').merge(section_id: section.id, position: lesson_position += 1),
  getting_hired_lessons.fetch('Conclusion').merge(section_id: section.id, position: lesson_position += 1),
]))

# Delete any removed seeds from the database
destroy_removed_seeds(course.lessons, seeded_lessons)
destroy_removed_seeds(course.sections, seeded_sections)
