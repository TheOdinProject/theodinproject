class AddIndexToAnnouncementsExpiresAt < ActiveRecord::Migration[6.1]
  def change
    add_index :announcements, :expires_at
  end
end
