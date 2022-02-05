require 'rails_helper'

RSpec.describe User::CommunityOnboardingComponent, type: :component do
  subject(:component) { described_class.new(current_user: user) }

  let(:user) { build_stubbed(:user, community_onboarding_steps: steps) }
  let(:step_one_title) { 'Community Rules' }
  let(:step_two_title) { 'How to Help Yourself Before Asking Others' }
  let(:step_three_title) { 'How to Ask Technical Questions' }
  let(:step_four_title) { 'Additional Community Expectations' }

  # rubocop: disable RSpec/MultipleMemoizedHelpers
  context 'when the user has not completed any onboarding steps' do
    let(:steps) { {} }

    it 'renders step 1 as the current step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='current-step-1']").and have_text(step_one_title)
    end

    it 'renders step 2 as an incomplete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='incomplete-step-2']").and have_text(step_two_title)
    end

    it 'renders step 3 as an incomplete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='incomplete-step-3']").and have_text(step_three_title)
    end

    it 'renders step 4 as an incomplete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='incomplete-step-4']").and have_text(step_four_title)
    end
  end

  context 'when the user has completed the first onboarding steps' do
    let(:steps) { { 'step_one' => 'true' } }

    it 'renders step 1 as a complete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='complete-step-1']").and have_text(step_one_title)
    end

    it 'renders step 2 as the current step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='current-step-2']").and have_text(step_two_title)
    end

    it 'renders step 3 as an incomplete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='incomplete-step-3']").and have_text(step_three_title)
    end

    it 'renders step 4 as an incomplete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='incomplete-step-4']").and have_text(step_four_title)
    end
  end

  context 'when the user has completed all of the onboarding steps' do
    let(:steps) { { 'step_one' => 'true', 'step_two' => 'true', 'step_three' => 'true', 'step_four' => 'true' } }

    it 'renders step 1 as a complete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='complete-step-1']").and have_text(step_one_title)
    end

    it 'renders step 2 as a complete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='complete-step-2']").and have_text(step_two_title)
    end

    it 'renders step 3 as a complete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='complete-step-3']").and have_text(step_three_title)
    end

    it 'renders step 4 as an complete step' do
      render_inline(component)

      expect(page).to have_css("a[data-test-id='complete-step-4']").and have_text(step_four_title)
    end
  end
  # rubocop: enable RSpec/MultipleMemoizedHelpers
end
