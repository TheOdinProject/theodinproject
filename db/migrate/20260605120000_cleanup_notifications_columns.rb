class CleanupNotificationsColumns < ActiveRecord::Migration[8.1]
  def change
    change_table :notifications, bulk: true do |t|
      t.remove :params, type: :jsonb
      t.remove :type, type: :string
    end
  end
end
