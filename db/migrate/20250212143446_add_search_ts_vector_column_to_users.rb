# rubocop:disable Rails/ReversibleMigration
class AddSearchTsVectorColumnToUsers < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    execute <<-SQL.squish
      ALTER TABLE users
      ADD COLUMN search_tsvector tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(email, '')), 'A') ||
        setweight(to_tsvector('english', coalesce(username,'')), 'B')
      ) STORED;
    SQL

    add_index :users, :search_tsvector, using: :gin, algorithm: :concurrently
  end
end
# rubocop:enable Rails/ReversibleMigration
