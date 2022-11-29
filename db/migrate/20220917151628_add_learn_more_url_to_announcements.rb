class AddLearnMoreUrlToAnnouncements < ActiveRecord::Migration[6.1]
  def change
    add_column :announcements, :learn_more_url, :string
  end
end
