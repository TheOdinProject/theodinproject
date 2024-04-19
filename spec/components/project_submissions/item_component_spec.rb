require 'rails_helper'

RSpec.describe ProjectSubmissions::ItemComponent, type: :component do
  context 'when the project submission is present' do
    it 'renders the item component' do
      project_submission = create(:project_submission)
      component = described_class.new(project_submission:)

      render_inline(component)

      expect(page).to have_css('[data-test-id="submission-item"]')
    end
  end

  context 'when the the project submission is not present' do
    it 'does not render the component' do
      component = described_class.new(project_submission: nil)

      render_inline(component)

      expect(page).to have_no_css('[data-test-id="submission-item"]')
    end
  end
end
