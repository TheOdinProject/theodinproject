require 'rails_helper'
require 'rake'

describe ':project_submissions' do
  before do
    Rake.application.rake_require 'tasks/lesson_previews'
    Rake::Task.define_task(:environment)
  end

  describe 'lesson_previews:destroy_expired' do
    let(:run_task) do
      Rake::Task['lesson_previews:destroy_expired'].reenable
      Rake.application.invoke_task 'lesson_previews:destroy_expired'
    end

    it 'deletes expired lesson previews' do
      create_list(:lesson_preview, 3, created_at: 1.month.ago)
      lesson_previews = create_list(:lesson_preview, 3)

      run_task

      expect(lesson_previews.map(&:id)).to match_array LessonPreview.all.map(&:id)
    end
  end
end
