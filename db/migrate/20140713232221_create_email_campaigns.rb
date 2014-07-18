class CreateEmailCampaigns < ActiveRecord::Migration
  def change
    create_table :email_campaigns do |t|
      t.string :name
      t.string :method_name
      t.string :status
      t.integer :email_campaign_category_id

      t.timestamps
    end
  end
end
