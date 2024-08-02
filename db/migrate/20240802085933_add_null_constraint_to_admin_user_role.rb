class AddNullConstraintToAdminUserRole < ActiveRecord::Migration[7.0]
  def change
    change_column_null :admin_users, :role, false
  end
end
