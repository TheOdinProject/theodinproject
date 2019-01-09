class CreateJoinTableTrackUnitLesson < ActiveRecord::Migration[5.0]
  def change
    create_join_table :track_units, :lessons do |t|
      t.index [:track_unit_id, :lesson_id]
    end
  end
end
