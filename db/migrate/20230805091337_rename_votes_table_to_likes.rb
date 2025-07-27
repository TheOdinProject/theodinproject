class RenameVotesTableToLikes < ActiveRecord::Migration[7.0]
  def up
    rename_table :votes, :likes

    rename_column :likes, :votable_id, :likeable_id
    rename_column :likes, :votable_type, :likeable_type
    rename_column :likes, :voter_id, :user_id

    change_column_null :likes, :likeable_id, false # rubocop:disable Rails/BulkChangeTable
    change_column_null :likes, :likeable_type, false
    change_column_null :likes, :user_id, false

    remove_column :likes, :voter_type
    remove_column :likes, :vote_flag
    remove_column :likes, :vote_scope
    remove_column :likes, :vote_weight

    add_index :likes, :user_id, if_not_exists: true
    add_index :likes, %i[likeable_id likeable_type], if_not_exists: true
    add_index :likes, %i[user_id likeable_id likeable_type], unique: true, if_not_exists: true
    add_foreign_key :likes, :users
  end

  def down
    remove_index :likes, %i[user_id likeable_id likeable_type]
    remove_foreign_key :likes, :users

    rename_table :likes, :votes

    rename_column :votes, :likeable_id, :votable_id
    rename_column :votes, :likeable_type, :votable_type
    rename_column :votes, :user_id, :voter_id

    change_column_null :votes, :votable_id, true # rubocop:disable Rails/BulkChangeTable
    change_column_null :votes, :votable_type, true
    change_column_null :votes, :voter_id, true

    # We're not using these columns currently
    # There will be no data loss if they need to be restored
    add_column :votes, :voter_type, :string
    add_column :votes, :vote_flag, :boolean # rubocop:disable Rails/ThreeStateBooleanColumn
    add_column :votes, :vote_scope, :string
    add_column :votes, :vote_weight, :integer
  end
end
