class CreateUnsubscriptions < ActiveRecord::Migration
  def change
    create_table :unsubscriptions do |t|
      t.belongs_to :user
      t.belongs_to :email_campaign_category
      t.timestamps
    end
  end
end
