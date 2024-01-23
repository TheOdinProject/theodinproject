Course.find_each do |course|
  course.update(
    projects_count: course.lessons.where(is_project: true).count,
    lessons_count: course.lessons.where(is_project: false).count
  )
end
