class AddTrackUnitToLessons < ActiveRecord::Migration[5.0]
  def change
    add_reference :lessons, :track_unit, foreign_key: true
  end
end
