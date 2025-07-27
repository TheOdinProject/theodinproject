class AddDeviseTwoFactorToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :otp_secret, :string # rubocop:disable Rails/BulkChangeTable
    add_column :admin_users, :consumed_timestep, :integer
    add_column :admin_users, :otp_required_for_login, :boolean, default: false # rubocop:disable Rails/ThreeStateBooleanColumn
  end
end
