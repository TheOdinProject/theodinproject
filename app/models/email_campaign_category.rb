class EmailCampaignCategory < ActiveRecord::Base
  has_many :email_campaigns
  validates :name, presence: true
  validates :name, uniqueness: true
end
