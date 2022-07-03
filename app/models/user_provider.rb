# == Schema Information
#
# Table name: user_providers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserProvider < ApplicationRecord
  belongs_to :user

  def self.find_user(auth)
    OmniauthProviders::Finder.find(auth).user
  end
end
