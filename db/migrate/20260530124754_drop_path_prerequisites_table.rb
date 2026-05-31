class DropPathPrerequisitesTable < ActiveRecord::Migration[8.1]
  def change
    drop_table :path_prerequisites # rubocop:disable Rails/ReversibleMigration
  end
end
