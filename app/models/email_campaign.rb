class EmailCampaign < ActiveRecord::Base
  attr_accessible :email_campaign_category, :method_name, :status

  belongs_to :email_campaign_category
  validates :email_campaign_category, presence: true
  validates :mailer_name, :method_name, presence: true
  validates :method_name, uniqueness: true

  has_many :users, :through => :sent_emails
end
