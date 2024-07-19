require 'rails_helper'

RSpec.describe RefreshMaterializedViewsJob do
  subject(:job) { described_class.new }

  describe '#perform' do
    before do
      allow(Reports::AllLessonCompletionsDayStat).to receive(:refresh)
      allow(Reports::PathLessonCompletionsDayStat).to receive(:refresh)
      allow(Reports::UserSignUpsDayStat).to receive(:refresh)
    end

    it 'refreshes all lesson completions day stats' do
      job.perform
      expect(Reports::AllLessonCompletionsDayStat).to have_received(:refresh)
    end

    it 'refreshes path lesson completions day stats' do
      job.perform
      expect(Reports::PathLessonCompletionsDayStat).to have_received(:refresh)
    end

    it 'refreshes user sign up day stats' do
      job.perform
      expect(Reports::UserSignUpsDayStat).to have_received(:refresh)
    end
  end
end
