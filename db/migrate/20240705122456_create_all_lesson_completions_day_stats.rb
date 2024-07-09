class CreateAllLessonCompletionsDayStats < ActiveRecord::Migration[7.0]
  def change
    create_view :all_lesson_completions_day_stats, materialized: true
  end
end
