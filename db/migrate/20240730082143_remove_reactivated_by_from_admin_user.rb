class RemoveReactivatedByFromAdminUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :admin_users, :reactivated_by_id, :bigint
  end
end
