class CreateJoinTableTracksCourses < ActiveRecord::Migration[5.0]
  def change
    create_join_table :tracks, :courses do |t|
      t.index [:track_id, :course_id]
      # t.index [:course_id, :track_id]
    end
  end
end
