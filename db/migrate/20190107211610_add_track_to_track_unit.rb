class AddTrackToTrackUnit < ActiveRecord::Migration[5.0]
  def change
    add_reference :track_units, :track
  end
end
