class AddTrackIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :track_id, :integer, default: Track.find_by(title: "Full Stack").id
  end
end
