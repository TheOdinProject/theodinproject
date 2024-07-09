require 'rails_helper'

RSpec.describe RefreshMaterializedViewsJob do
  subject(:job) { described_class.new }

  describe '#perform' do
    before do
      allow(Reports::AllLessonCompletionsDayStat).to receive(:refresh)
    end

    it 'refreshes all lesson completions day stats' do
      job.perform
      expect(Reports::AllLessonCompletionsDayStat).to have_received(:refresh)
    end
  end
end
