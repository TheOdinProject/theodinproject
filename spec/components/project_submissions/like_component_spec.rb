require 'rails_helper'

RSpec.describe ProjectSubmissions::LikeComponent, type: :component do
  context 'when the the project submission is liked' do
    it 'renders the component as liked' do
      project_submission = create(:project_submission, :liked)
      component = described_class.new(project_submission:)

      render_inline(component)

      expect(page).to have_css('.stroke-teal-700')
    end
  end

  context 'when the the project submission is unliked' do
    it 'renders the component as liked' do
      project_submission = create(:project_submission, :unliked)
      component = described_class.new(project_submission:)

      render_inline(component)

      expect(page).to have_css('.stroke-gray-500')
    end
  end

  context 'when the the project submission belongs to the current user' do
    it 'always renders the component as liked' do
      project_submission = create(:project_submission, :unliked)
      component = described_class.new(project_submission:, current_users_submission: true)

      render_inline(component)

      expect(page).to have_css('.stroke-teal-700')
    end
  end
end
