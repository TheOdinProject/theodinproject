class AddUnsubscribeAllToUser < ActiveRecord::Migration
  def change
    add_column :users, :unsubscribe_all, :boolean, default: false
  end
end
