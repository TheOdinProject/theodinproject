class DropPointsTable < ActiveRecord::Migration[8.1]
  def change
    drop_table :points # rubocop:disable Rails/ReversibleMigration
  end
end
