require 'rails_helper'

RSpec.describe Flags::Actions::Ban do
  let(:admin_user) { create(:admin_user) }
  let(:flag) { create(:flag) }

  describe '#perform' do
    context 'when successful' do
      it 'bans the learner' do
        project_submission_owner = instance_double(User, ban!: true)
        allow(flag).to receive(:project_submission_owner).and_return(project_submission_owner)

        described_class.perform(admin_user:, flag:)

        expect(project_submission_owner).to have_received(:ban!)
      end

      it "changes the flag action taken to 'ban'" do
        expect { described_class.perform(admin_user:, flag:) }
          .to change { flag.reload.taken_action }.from('pending').to('ban')
      end

      it 'resolves the flag' do
        expect { described_class.perform(admin_user:, flag:) }
          .to change { flag.reload.resolved? }.from(false).to(true)
      end

      it 'returns a successful result' do
        result = described_class.perform(admin_user:, flag:)

        expect(result).to be_success
        expect(result.message).to eq('Project submission owner has been banned')
      end
    end
  end

  context 'when unsuccessful' do
    it 'returns an unsuccessful result' do
      allow(flag).to receive(:resolved?).and_return(false)

      expect(described_class.perform(admin_user:, flag:)).not_to be_success
    end
  end
end
