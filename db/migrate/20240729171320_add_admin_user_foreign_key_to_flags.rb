class AddAdminUserForeignKeyToFlags < ActiveRecord::Migration[7.0]
  def change
    add_reference :flags, :admin_user, foreign_key: true, index: true
  end
end
