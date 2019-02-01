class AddTrackIdToUser < ActiveRecord::Migration[5.0]
  def track_id
    if Track.find_by(title: "Full Stack")
      Track.find_by(title: "Full Stack").id
    else
      1
    end
  end
  def change
    add_column :users, :track_id, :integer, default: track_id
  end
end
