require 'rails_helper'

RSpec.describe User::LearningGoalComponent, type: :component do
  context 'when the user has a learning goal' do
    it 'renders the learning goal' do
      user = create(:user, learning_goal: 'Learn Ruby')
      component = described_class.new(current_user: user)

      render_inline(component)

      expect(page).to have_content('Learn Ruby')
    end
  end

  context 'when the user does not have a learning goal' do
    it 'renders a link to settings' do
      user = create(:user, learning_goal: nil)
      component = described_class.new(current_user: user)

      render_inline(component)

      expect(page).to have_link(
        "What's your learning goal?",
        href: '/users/profile/edit?learning_goal=true'
      )
    end
  end
end
