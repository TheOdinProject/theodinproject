class EmailCampaignCategory < ActiveRecord::Base
  has_many :email_campaigns
end
