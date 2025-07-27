class AddUrlAndMessageToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :url, :string, null: false   # rubocop:disable Rails/BulkChangeTable, Rails/NotNullColumn
    add_column :notifications, :message, :text, null: false # rubocop:disable Rails/NotNullColumn
  end
end
