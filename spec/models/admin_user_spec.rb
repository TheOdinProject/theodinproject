require 'rails_helper'

RSpec.describe AdminUser do
  subject { create(:admin_user) }

  it_behaves_like 'authenticatable_with_two_factor', :admin_user
  it_behaves_like 'two_factor_authenticatable'

  it { is_expected.to belong_to(:deactivated_by).class_name('AdminUser').optional }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }

  describe '#initials' do
    it 'returns the initials of the admin user' do
      admin_user = build(:admin_user, name: 'John Wick')
      expect(admin_user.initials).to eq 'JW'
    end
  end

  describe '#active_for_authentication?' do
    context 'when admin has not been deactivated' do
      it 'returns true' do
        admin = create(:admin_user)
        expect(admin).to be_active_for_authentication
      end
    end

    context 'when admin has been deactivated' do
      it 'returns false' do
        admin = create(:admin_user, status: :deactivated)
        expect(admin).not_to be_active_for_authentication
      end
    end
  end

  describe '#inactive_message' do
    context 'when admin has not been deactivated' do
      it 'returns default inactive translation key' do
        admin = create(:admin_user)
        expect(admin.inactive_message).to eq(:inactive)
      end
    end

    context 'when admin has been deactivated' do
      it 'returns banned translation key' do
        admin = create(:admin_user, status: :deactivated)
        expect(admin.inactive_message).to eq(:deactivated)
      end
    end
  end

  describe '#activate!' do
    it 'activates the admin' do
      admin = build(:admin_user, status: :pending)

      expect do
        admin.activate!
      end.to change { admin.status }.from('pending').to('active')
    end
  end

  describe '#deactivate!' do
    it 'deactivates the admin' do
      admin = build(:admin_user, status: :active)
      deactivator = build(:admin_user)

      expect do
        admin.deactivate!(deactivator:)
      end.to change { admin.status }.from('active').to('deactivated')
    end

    it 'sets the deactivator' do
      admin = build(:admin_user, status: :active)
      deactivator = build(:admin_user)

      expect do
        admin.deactivate!(deactivator:)
      end.to change { admin.deactivated_by }.from(nil).to(deactivator)
    end

    it 'sets the deactivated_at timestamp' do
      admin = build(:admin_user, status: :active)
      deactivator = build(:admin_user)

      freeze_time do
        expect do
          admin.deactivate!(deactivator:)
        end.to change { admin.deactivated_at }.from(nil).to(Time.current)
      end
    end

    context 'when the admin is already deactivated' do
      it 'does not deactivate the admin' do
        admin = build(:admin_user, status: :deactivated)
        deactivator = build(:admin_user)

        expect { admin.deactivate!(deactivator:) }.not_to change { admin.status }
      end
    end
  end

  describe '#reactivate!' do
    it 'reactivates the admin' do
      admin = build(:admin_user, status: :deactivated)
      activator = build(:admin_user)

      expect do
        admin.reactivate!(activator:)
      end.to change { admin.status }.from('deactivated').to('pending')
    end

    it 'sets the reactivator' do
      admin = build(:admin_user, status: :deactivated)
      activator = build(:admin_user)

      expect do
        admin.reactivate!(activator:)
      end.to change { admin.reactivated_by }.from(nil).to(activator)
    end

    it 'sets the reactivated_at timestamp' do
      admin = build(:admin_user, status: :deactivated)
      activator = build(:admin_user)

      freeze_time do
        expect do
          admin.reactivate!(activator:)
        end.to change { admin.reactivated_at }.from(nil).to(Time.current)
      end
    end

    context 'when the admin is already active' do
      it 'does not reactivate the admin' do
        admin = build(:admin_user, status: :active)
        activator = build(:admin_user)

        expect { admin.reactivate!(activator:) }.not_to change { admin.status }
      end
    end
  end

  describe '#enable_two_factor!' do
    it 'activates the admin' do
      admin = build(:admin_user, status: :pending)

      expect do
        admin.enable_two_factor!
      end.to change { admin.status }.from('pending').to('active')
    end
  end

  describe '#reset_two_factor!' do
    it 'sets the admin to pending' do
      admin = build(:admin_user, status: :active)

      expect do
        admin.reset_two_factor!
      end.to change { admin.status }.from('active').to('pending')
    end
  end
end
