class SentEmail < ActiveRecord::Base
  belongs_to :user
  belongs_to :email_campaign
end
