class CreateSentEmails < ActiveRecord::Migration
  def change
    create_table :sent_emails do |t|
      t.belongs_to :user
      t.belongs_to :email_campaign
      t.timestamps
    end
  end
end
