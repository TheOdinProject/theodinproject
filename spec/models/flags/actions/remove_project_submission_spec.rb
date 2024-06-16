require 'rails_helper'

RSpec.describe Flags::Actions::RemoveProjectSubmission do
  let(:admin_user) { create(:admin_user) }
  let(:flag) { create(:flag) }

  describe '#perform' do
    context 'when successful' do
      it 'removes the project submission' do
        expect { described_class.perform(admin_user:, flag:) }
          .to change { flag.project_submission.reload.discarded? }.from(false).to(true)
      end

      it "changes the flag action taken to 'removed_project_submission'" do
        expect { described_class.perform(admin_user:, flag:) }
          .to change { flag.reload.taken_action }.from('pending').to('removed_project_submission')
      end

      it 'resolves the flag' do
        expect { described_class.perform(admin_user:, flag:) }
          .to change { flag.reload.resolved? }.from(false).to(true)
      end

      it 'returns a successful result' do
        result = described_class.perform(admin_user:, flag:)

        expect(result).to be_success
        expect(result.message).to eq('Project submission removed')
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
