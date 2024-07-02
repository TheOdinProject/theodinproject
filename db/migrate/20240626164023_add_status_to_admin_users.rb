class AddStatusToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :status, %w[pending active deactivated]

    add_column :admin_users, :status, :enum, enum_type: :status, default: 'pending', null: false
  end
end
