class Unsubscription < ActiveRecord::Base
  validates :user_id, :email_campaign_category_id, presence: true
  validates_uniqueness_of :user_id, :scope => :email_campaign_category_id
  attr_accessible :user_id, :email_campaign_category_id

  def self.unsubscribe(user, category_names)
    category_names.each do |name|
      Unsubscription.create(user_id: user.id, 
        email_campaign_category_id: EmailCampaignCategory.find_by_name(name).id)
    end
  end
end