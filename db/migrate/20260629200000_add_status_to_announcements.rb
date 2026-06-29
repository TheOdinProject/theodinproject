class AddStatusToAnnouncements < ActiveRecord::Migration[8.1]
  def change
    add_column :announcements, :status, :integer, default: 0, null: false
    add_index :announcements, :status

    reversible do |dir|
      dir.up do
        execute('UPDATE announcements SET status = 1 WHERE expires_at <= NOW()')
      end
    end
  end
end
