SELECT
  ROW_NUMBER() OVER (ORDER BY lesson_completions.created_at::DATE DESC) as id,
  lesson_completions.path_id,
  lesson_id,
  lesson_completions.course_id,
  lessons.position as lesson_position,
  courses.position as course_position,
  lesson_completions.created_at::DATE as date,
  lessons.title as lesson_title,
  COUNT(*) AS completions_count
FROM lesson_completions
  JOIN lessons ON lesson_completions.lesson_id = lessons.id
  JOIN courses ON lesson_completions.course_id = courses.id
  GROUP BY lesson_completions.created_at::DATE, lesson_completions.path_id, lesson_id, lesson_title, lesson_completions.course_id, lesson_position, course_position
  ORDER BY lesson_completions.created_at::DATE DESC
