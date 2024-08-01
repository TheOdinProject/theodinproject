require 'rails_helper'

RSpec.describe AdminUser do
  subject(:admin_user) { create(:admin_user) }

  it_behaves_like 'authenticatable_with_two_factor', :admin_user
  it_behaves_like 'two_factor_authenticatable'

  it { is_expected.to have_many(:flags).dependent(:nullify) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }

  it do
    expect(admin_user).to define_enum_for(:status).with_values(
      {
        pending: 'pending',
        activated: 'activated',
        deactivated: 'deactivated',
        pending_reactivation: 'pending_reactivation'
      }
    ).backed_by_column_of_type(:enum)
  end

  it do
    expect(admin_user).to define_enum_for(:role).with_values(
      { moderator: 'moderator', maintainer: 'maintainer', core: 'core' }
    ).backed_by_column_of_type(:enum)
  end

  describe '.ordered' do
    it 'orders the admin users by created_at descending' do
      admin_created_today = create(:admin_user)
      admin_created_last_week = create(:admin_user, created_at: 1.week.ago)
      admin_created_yesterday = create(:admin_user, created_at: 1.day.ago)

      expect(described_class.ordered).to eq([admin_created_today, admin_created_yesterday, admin_created_last_week])
    end
  end

  describe '.awaiting_activation' do
    it 'returns admin users that are pending or pending reactivation' do
      pending_admin = create(:admin_user, :pending)
      pending_reactivation_admin = create(:admin_user, :pending_reactivation)
      active_admin = create(:admin_user, :activated)

      expect(described_class.awaiting_activation).to contain_exactly(
        pending_admin,
        pending_reactivation_admin
      )
    end
  end

  describe 'allowed status changes' do
    context 'when the admin is pending' do
      subject { create(:admin_user, :pending) }

      it { is_expected.to allow_transition_to(:activated) }
      it { is_expected.to allow_transition_to(:deactivated) }
      it { is_expected.not_to allow_transition_to(:pending_reactivation) }
    end

    context 'when the admin is activated' do
      subject { create(:admin_user, :activated) }

      it { is_expected.to allow_transition_to(:deactivated) }
      it { is_expected.not_to allow_transition_to(:pending) }
      it { is_expected.not_to allow_transition_to(:pending_reactivation) }
    end

    context 'when the admin is pending reactivation' do
      subject { create(:admin_user, :pending_reactivation) }

      it { is_expected.to allow_transition_to(:deactivated) }
      it { is_expected.to allow_transition_to(:activated) }
      it { is_expected.not_to allow_transition_to(:pending) }
    end
  end

  describe '#activate!' do
    it 'transitions the admin to activated' do
      admin = create(:admin_user, :pending)
      expect { admin.activate! }.to change { admin.reload.status }.from('pending').to('activated')
    end

    it 'logs the status change' do
      admin = create(:admin_user, :pending)

      expect { admin.activate! }.to change { admin.activities.count }.by(1)
    end
  end

  describe '#deactivate' do
    it 'transitions the admin to deactivated' do
      admin = create(:admin_user, :activated)
      expect { admin.deactivate! }.to change { admin.reload.status }.from('activated').to('deactivated')
    end

    it 'logs the status change' do
      admin = create(:admin_user, :activated)

      expect { admin.deactivate! }.to change { admin.activities.count }.by(1)
    end
  end

  describe '#reactivate!' do
    it 'transitions the admin to pending reactivation' do
      admin = create(:admin_user, :deactivated)
      expect { admin.reactivate! }.to change { admin.reload.status }.from('deactivated').to('pending_reactivation')
    end

    it 'logs the status change' do
      admin = create(:admin_user, :deactivated)

      expect { admin.reactivate! }.to change { admin.activities.count }.by(1)
    end

    it 'sets the reactivated_at timestamp' do
      admin = create(:admin_user, :deactivated)

      freeze_time do
        expect { admin.reactivate! }.to change { admin.reactivated_at }.from(nil).to(Time.current)
      end
    end
  end

  describe '#awaiting_activation?' do
    context 'when the admin is pending' do
      subject { build(:admin_user, :pending) }

      it { is_expected.to be_awaiting_activation }
    end

    context 'when the admin is pending reactivation' do
      subject { build(:admin_user, :pending_reactivation) }

      it { is_expected.to be_awaiting_activation }
    end

    context 'when the admin is not pending or pending reactivation' do
      subject { build(:admin_user, :activated) }

      it { is_expected.not_to be_awaiting_activation }
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
        admin = create(:admin_user, :deactivated)
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
        admin = create(:admin_user, :deactivated)
        expect(admin.inactive_message).to eq(:deactivated)
      end
    end
  end

  describe '#enable_two_factor!' do
    it 'activates the admin' do
      admin = build(:admin_user, :pending)

      expect do
        admin.enable_two_factor!
      end.to change { admin.status }.from('pending').to('activated')
    end
  end

  describe '#remove!' do
    context 'when the admin is not awaiting activation' do
      it 'does not remove activated admins' do
        admin = build(:admin_user, :activated)
        expect { admin.remove! }.not_to change { admin.status }
      end

      it 'does not remove deactivated admins' do
        admin = build(:admin_user, :deactivated)
        expect { admin.remove! }.not_to change { admin.status }
      end
    end

    context 'when the admin has previously accepted an invite' do
      it 'deactivates the admin' do
        admin = create(:admin_user, :pending, invitation_accepted_at: 10.days.ago)
        expect { admin.remove! }.to change { admin.reload.status }.from('pending').to('deactivated')
      end
    end

    context 'when the admin has not accepted their invite' do
      it 'destroys the admin' do
        admin = create(:admin_user, :pending)

        expect { admin.remove! }.to change { described_class.count }.by(-1)
      end
    end
  end
end
