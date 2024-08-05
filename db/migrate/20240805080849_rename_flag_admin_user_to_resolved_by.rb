class RenameFlagAdminUserToResolvedBy < ActiveRecord::Migration[7.0]
  def change
    remove_column :flags, :resolved_by_id, :integer
    rename_column :flags, :admin_user_id, :resolved_by_id
  end
end
