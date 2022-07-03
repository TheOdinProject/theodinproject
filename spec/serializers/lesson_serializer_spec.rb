# == Schema Information
#
# Table name: lessons
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  github_path         :string(255)
#  position            :integer          not null
#  description         :text
#  is_project          :boolean          default(FALSE)
#  section_id          :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  content             :text
#  slug                :string
#  accepts_submission  :boolean          default(FALSE), not null
#  has_live_preview    :boolean          default(FALSE), not null
#  choose_path_lesson  :boolean          default(FALSE), not null
#  identifier_uuid     :string           default(""), not null
#  course_id           :bigint
#  installation_lesson :boolean          default(FALSE)
#
require 'rails_helper'

RSpec.describe LessonSerializer do
  subject { described_class.as_json(lesson, between_dates) }

  let(:lesson) { instance_double(Lesson, title: 'Overview', lesson_completions:) }
  let(:between_dates) { (DateTime.parse('2019/01/01')..DateTime.parse('2019/12/31')) }
  let(:lesson_completions) { [lesson_completion] }
  let(:lesson_completion) { instance_double(LessonCompletion, created_at: '2019/01/10') }

  describe '#as_json' do
    let(:serialized_lesson) do
      {
        title: 'Overview',
        completions: 1
      }
    end

    before do
      allow(lesson_completions).to receive(:where)
        .with(created_at: between_dates)
        .and_return([lesson_completion])
    end

    it { is_expected.to eql(serialized_lesson) }
  end
end
