class AddRolesToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :admin_roles, %w[moderator maintainer core]

    add_column :admin_users, :role, :enum, enum_type: :admin_roles
  end
end
