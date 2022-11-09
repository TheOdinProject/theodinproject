require 'rails_helper'

RSpec.describe LessonPreviewsRemover do
  describe '#call' do
    context 'with lesson_previews older than a month' do
      it 'removes lesson_previews' do
        create_list(:lesson_preview, 5, created_at: 1.month.ago)

        expect { described_class.new.call }.to change { LessonPreview.count }.by(-5)
      end
    end

    context 'with lesson_previews created current month' do
      it 'does not remove lesson_previews' do
        create_list(:lesson_preview, 5)

        expect { described_class.new.call }.not_to change { LessonPreview.count }
      end
    end
  end
end
