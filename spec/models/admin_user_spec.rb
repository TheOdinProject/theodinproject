require 'rails_helper'

RSpec.describe AdminUser do
  subject { create(:admin_user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }

  describe 'after invitation accepted' do
    it 'activates the user' do
      admin_user = create(:admin_user, status: :pending)
      admin_user.invite!

      expect do
        admin_user.accept_invitation!
      end.to change { admin_user.status }.from('pending').to('active')
    end
  end

  describe '#initials' do
    it 'returns the initials of the admin user' do
      admin_user = build(:admin_user, name: 'John Wick')
      expect(admin_user.initials).to eq 'JW'
    end
  end
end
