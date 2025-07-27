class AddTitleToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :title, :string, null: false # rubocop:disable Rails/NotNullColumn
  end
end
