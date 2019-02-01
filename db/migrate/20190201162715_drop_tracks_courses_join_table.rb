class DropTracksCoursesJoinTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :courses_tracks
  end
end
