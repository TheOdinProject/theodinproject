require 'rails_helper'

RSpec.describe Flags::Actions::NullAction do
  let(:admin_user) { create(:admin_user) }
  let(:flag) { create(:flag) }

  describe '#perform' do
    it 'returns an unsuccessful result' do
      result = described_class.perform(admin_user:, flag:)

      expect(result).not_to be_success
      expect(result.message).to eq('Failed: Unknown action')
    end
  end
end
