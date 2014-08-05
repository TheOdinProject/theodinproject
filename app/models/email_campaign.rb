class EmailCampaign < ActiveRecord::Base
  attr_accessible :email_campaign_category, :method_name, :status

  belongs_to :email_campaign_category
  has_many :users, :through => :sent_emails
  validates :name, :method_name, presence: true
  validates :name, :method_name, uniqueness: true
end
