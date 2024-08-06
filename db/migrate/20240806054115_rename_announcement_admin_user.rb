class RenameAnnouncementAdminUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :announcements, :user_id, :bigint
    rename_column :announcements, :admin_user_id, :created_by_id
    change_column_null :announcements, :created_by_id, false
  end
end
