require 'rails_helper'

RSpec.describe AdminUser do
  subject { create(:admin_user) }

  it_behaves_like 'authenticatable_with_two_factor', :admin_user
  it_behaves_like 'two_factor_authenticatable'

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }

  describe '.ordered' do
    it 'orders the admin users by created_at descending' do
      admin_created_today = create(:admin_user)
      admin_created_last_week = create(:admin_user, created_at: 1.week.ago)
      admin_created_yesterday = create(:admin_user, created_at: 1.day.ago)

      expect(described_class.ordered).to eq([admin_created_today, admin_created_yesterday, admin_created_last_week])
    end
  end

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
    context 'when the admin is active' do
      it 'deactivates the admin' do
        admin = build(:admin_user, status: :active)

        expect do
          admin.deactivate!
        end.to change { admin.status }.from('active').to('deactivated')
      end

      it 'sets the deactivated_at timestamp' do
        admin = build(:admin_user, status: :active)

        freeze_time do
          expect do
            admin.deactivate!
          end.to change { admin.deactivated_at }.from(nil).to(Time.current)
        end
      end
    end

    context 'when the admin has been reactivated' do
      it 'deactivates the admin' do
        admin = build(:admin_user, status: :pending, reactivated_at: 1.day.ago)

        expect do
          admin.deactivate!
        end.to change { admin.status }.from('pending').to('deactivated')
      end

      it 'sets the deactivated_at timestamp' do
        admin = build(:admin_user, status: :pending, reactivated_at: 1.day.ago)

        freeze_time do
          expect do
            admin.deactivate!
          end.to change { admin.deactivated_at }.from(nil).to(Time.current)
        end
      end
    end

    context 'when the admin is already deactivated' do
      it 'does not deactivate the admin' do
        admin = build(:admin_user, status: :deactivated)

        expect { admin.deactivate! }.not_to change { admin.status }
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

  describe '#remove!' do
    context 'when the admin is not pending' do
      it 'does not remove active admins' do
        admin = build(:admin_user, status: :active)
        expect { admin.remove! }.not_to change { admin.status }
      end

      it 'does not remove deactivated admins' do
        admin = build(:admin_user, status: :deactivated)
        expect { admin.remove! }.not_to change { admin.status }
      end
    end

    context 'when the admin has been previously reactivated' do
      it 'deactivates the admin' do
        admin = create(:admin_user, status: :pending, reactivated_at: 1.day.ago)
        expect { admin.remove! }.to change { admin.reload.status }.from('pending').to('deactivated')
      end
    end

    context 'when the admin has not been previously reactivated' do
      it 'destroys the admin' do
        admin = create(:admin_user, status: :pending)

        expect { admin.remove! }.to change { described_class.count }.by(-1)
      end
    end
  end
end
