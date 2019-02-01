class CreateTrackCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :track_courses do |t|
      t.integer :track_id
      t.integer :course_id
      t.integer :track_position

      t.timestamps
    end
  end
end
