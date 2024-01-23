class AddLessonAndProjectCountsToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :lessons_count, :integer, default: 0, null: false
    add_column :courses, :projects_count, :integer, default: 0, null: false
  end
end
