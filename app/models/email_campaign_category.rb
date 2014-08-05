class EmailCampaignCategory < ActiveRecord::Base
  attr_accessible :name
  
  has_many :email_campaigns
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.list
    categories = []
    self.all.each do |c|
      categories << c.name unless c.name.match(/transactional/i)
    end
    return categories
  end
end
