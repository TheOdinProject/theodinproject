class EmailCampaignCategory < ActiveRecord::Base
  attr_accessible :name
  
  has_many :email_campaigns
  validates :name, :description, presence: true
  validates :name, uniqueness: true

  def self.list
    EmailCampaignCategory.where.not(name: "Transactional").where.not(name: "transactional")
  end
end
