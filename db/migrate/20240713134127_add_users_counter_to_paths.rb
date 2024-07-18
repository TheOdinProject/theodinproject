class AddUsersCounterToPaths < ActiveRecord::Migration[7.0]
  def up
    add_column :paths, :users_count, :integer, default: 0

    Path.find_each do |path|
      Path.reset_counters(path.id, :users)
    end
  end
end
