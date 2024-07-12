class AddReactivationToAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :reactivated_at, :datetime
    add_reference :admin_users, :reactivated_by, foreign_key: { to_table: :admin_users }
  end
end
