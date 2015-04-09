class CreateCourseCompletions < ActiveRecord::Migration
  def change
    create_table :course_completions do |t|
      t.integer :course_id
      t.integer :student_id
      t.timestamps
    end
      add_index :course_completions, [:course_id, :student_id], :unique => true
  end
end
