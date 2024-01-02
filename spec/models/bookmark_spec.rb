require 'rails_helper'

RSpec.describe Bookmark do
  subject(:bookmark) { create(:bookmark, lesson:) }

  let!(:lesson) { create(:lesson, section: create(:section, course:), course:) }
  let!(:course) { create(:course) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:lesson) }
  end

  describe 'validations' do
    it 'validates uniqueness of lesson scoped to user' do
      pending 'type error, course not getting attached to lesson'
      expect(bookmark)
        .to validate_uniqueness_of(:lesson)
        .scoped_to(:user)
        .with_message('user has already bookmarked this lesson')
    end
  end
end
