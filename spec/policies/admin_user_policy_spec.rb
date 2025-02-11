require 'rails_helper'

RSpec.describe AdminUserPolicy do
  describe '#change_role?' do
    subject(:policy) { described_class.new(admin_user).change_role? }

    context 'when the admin user has the core role' do
      let(:admin_user) { create(:admin_user, role: 'core') }

      it { is_expected.to be(true) }
    end

    context 'when the admin user has the maintainer role' do
      let(:admin_user) { create(:admin_user, role: 'maintainer') }

      it { is_expected.to be(false) }
    end

    context 'when the admin user has the moderator role' do
      let(:admin_user) { create(:admin_user, role: 'moderator') }

      it { is_expected.to be(false) }
    end
  end

  describe '#invite?' do
    subject(:policy) { described_class.new(admin_user).invite? }

    context 'when the admin user has the core role' do
      let(:admin_user) { create(:admin_user, role: 'core') }

      it { is_expected.to be(true) }
    end

    context 'when the admin user has the maintainer role' do
      let(:admin_user) { create(:admin_user, role: 'maintainer') }

      it { is_expected.to be(true) }
    end

    context 'when the admin user has the moderator role' do
      let(:admin_user) { create(:admin_user, role: 'moderator') }

      it { is_expected.to be(false) }
    end
  end

  describe '#deactivate?' do
    subject(:policy) { described_class.new(admin_user).deactivate? }

    context 'when the admin user has the core role' do
      let(:admin_user) { create(:admin_user, role: 'core') }

      it { is_expected.to be(true) }
    end

    context 'when the admin user has the maintainer role' do
      let(:admin_user) { create(:admin_user, role: 'maintainer') }

      it { is_expected.to be(false) }
    end

    context 'when the admin user has the moderator role' do
      let(:admin_user) { create(:admin_user, role: 'moderator') }

      it { is_expected.to be(false) }
    end
  end

  describe '#reactivate?' do
    subject(:policy) { described_class.new(admin_user).reactivate? }

    context 'when the admin user has the core role' do
      let(:admin_user) { create(:admin_user, role: 'core') }

      it { is_expected.to be(true) }
    end

    context 'when the admin user has the maintainer role' do
      let(:admin_user) { create(:admin_user, role: 'maintainer') }

      it { is_expected.to be(true) }
    end

    context 'when the admin user has the moderator role' do
      let(:admin_user) { create(:admin_user, role: 'moderator') }

      it { is_expected.to be(false) }
    end
  end

  describe '#reset_2fa?' do
    subject(:policy) { described_class.new(admin_user).reset_2fa? }

    context 'when the admin user has the core role' do
      let(:admin_user) { create(:admin_user, role: 'core') }

      it { is_expected.to be(true) }
    end

    context 'when the admin user has the maintainer role' do
      let(:admin_user) { create(:admin_user, role: 'maintainer') }

      it { is_expected.to be(false) }
    end

    context 'when the admin user has the moderator role' do
      let(:admin_user) { create(:admin_user, role: 'moderator') }

      it { is_expected.to be(false) }
    end
  end

  describe '#delete_learner?' do
    subject(:policy) { described_class.new(admin_user).delete_learner? }

    context 'when the admin user has the core role' do
      let(:admin_user) { create(:admin_user, role: 'core') }

      it { is_expected.to be(true) }
    end

    context 'when the admin user has the maintainer role' do
      let(:admin_user) { create(:admin_user, role: 'maintainer') }

      it { is_expected.to be(false) }
    end

    context 'when the admin user has the moderator role' do
      let(:admin_user) { create(:admin_user, role: 'moderator') }

      it { is_expected.to be(false) }
    end
  end
end
