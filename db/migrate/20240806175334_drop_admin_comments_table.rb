class DropAdminCommentsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :active_admin_comments
  end
end
