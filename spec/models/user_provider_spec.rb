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
require 'rails_helper'

RSpec.describe UserProvider do
  it { is_expected.to belong_to(:user) }

  describe '.find_user' do
    let(:auth) { {} }
    let(:user_provider_finder) { instance_double(OmniauthProviders::Finder) }
    let(:user_provider) { instance_double(described_class, user:) }
    let(:user) { instance_double(User) }

    before do
      allow(OmniauthProviders::Finder).to receive(:find)
        .with(auth)
        .and_return(user_provider)
    end

    it 'returns the user who owns the user provider' do
      expect(described_class.find_user(auth)).to eql(user)
    end
  end
end
