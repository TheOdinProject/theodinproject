# == Schema Information
#
# Table name: courses
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  position         :integer          not null
#  slug             :string
#  identifier_uuid  :string           default(""), not null
#  path_id          :integer
#  show_on_homepage :boolean          default(FALSE), not null
#  badge_uri        :string           not null
#
require 'rails_helper'

RSpec.describe Course do
  subject(:course) { described_class.new }

  it { is_expected.to belong_to(:path) }
  it { is_expected.to have_many(:sections).order(:position) }
  it { is_expected.to have_many(:lessons).through(:sections) }

  it { is_expected.to validate_presence_of(:position) }

  describe '.badges' do
    it 'only displays homepage badges' do
      create_list(:course, 2)
      course_three = create(:course, show_on_homepage: true)

      expect(described_class.badges).to contain_exactly(course_three)
    end
  end

  describe '#progress_for' do
    let(:course) { build_stubbed(:course) }
    let(:user) { build_stubbed(:user) }

    before do
      allow(user).to receive(:progress_for)
    end

    it 'returns the users progress for the course' do
      course.progress_for(user)
      expect(user).to have_received(:progress_for).with(course)
    end
  end
end
