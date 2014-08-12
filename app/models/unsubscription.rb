class Unsubscription < ActiveRecord::Base
  validates :user_id, :email_campaign_category_id, presence: true
  validates_uniqueness_of :user_id, :scope => :email_campaign_category_id
  attr_accessible :user_id, :email_campaign_category_id

  def self.unsubscribe(user, category_names)
    # category_names should be an array of strings
    ecc_list = []
    category_names.each do |c|
      ecc_list << EmailCampaignCategory.find_by_name(c)
    end
    ecc_list.each do |c|
      Unsubscription.create(user_id: user.id, email_campaign_category_id: c.id)
    end
  end

  def self.category_names(unsubscriptions)
    # unsubscriptions should be an array of Unsubscription objects
    # returns array of category names as strings
    list = []
    unsubscriptions.each do |u|
      category = EmailCampaignCategory.find(u.email_campaign_category_id)
      list << category.name
    end
    return list
  end
end