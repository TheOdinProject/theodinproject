class AdjustEmailCampaignsAndCategories < ActiveRecord::Migration
  def change
    change_table :email_campaign_categories do |t|
      t.string :description
    end

    change_table :email_campaigns do |t| 
      t.rename :name, :mailer_name
      t.date :last_sent
    end
  end
end
