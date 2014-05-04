class AddColumnForUsersRegisteredBeforeConfirmation < ActiveRecord::Migration
  def change
    add_column :users, :reg_before_conf, :boolean, default: false
  end
end
