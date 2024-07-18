class CreatePathLessonCompletionsDayStats < ActiveRecord::Migration[7.0]
  def change
    create_view :path_lesson_completions_day_stats, materialized: true
  end
end
