require 'rails_helper'

RSpec.describe DestroyExpiredLessonPreviewsJob do
  subject(:job) { described_class.new }

  describe '#perform' do
    context 'when there are expired lesson previews' do
      it 'deletes 3 expired lesson previews' do
        create_list(:lesson_preview, 3, created_at: 1.month.ago)

        expect { job.perform }.to change { LessonPreview.count }.from(3).to(0)
      end

      it 'does not delete not expired lesson previews' do
        create_list(:lesson_preview, 3)

        expect { job.perform }.not_to change { LessonPreview.count }
      end
    end
  end
end
