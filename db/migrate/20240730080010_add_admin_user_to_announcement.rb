class AddAdminUserToAnnouncement < ActiveRecord::Migration[7.0]
  def change
    add_reference :announcements, :admin_user, foreign_key: true, index: true
  end
end
