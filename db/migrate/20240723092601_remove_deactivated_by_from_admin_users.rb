class RemoveDeactivatedByFromAdminUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :admin_users, :deactivated_by_id, :bigint
  end
end
