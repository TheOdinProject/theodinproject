class CreateEmailCampaignCategories < ActiveRecord::Migration
  def change
    create_table :email_campaign_categories do |t|
      t.string :name
      t.timestamps
    end

    # Wrong way to set up relationship between campaigns and categories
    remove_column(:email_campaigns, :email_campaign_category_id)

    # Right way to set up relationship between campaigns and categories
    change_table :email_campaigns do |t|
      t.belongs_to :email_campaign_category  # Right way to set up relationship
    end
  end
end
