require 'rails_helper'

RSpec.describe Feature do
  describe '.enabled?' do
    context 'when the feature is enabled' do
      it 'returns true' do
        actor = instance_double(User)
        allow(Flipper).to receive(:enabled?).with(:test_feature, actor).and_return(true)

        expect(described_class.enabled?(:test_feature, actor)).to be(true)
      end
    end

    context 'when the feature is disabled' do
      it 'returns false' do
        actor = instance_double(User)
        allow(Flipper).to receive(:enabled?).with(:test_feature, actor).and_return(false)

        expect(described_class.enabled?(:test_feature, actor)).to be(false)
      end
    end
  end
end
