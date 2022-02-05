class User::CommunityOnboardingComponent < ViewComponent::Base
  def initialize(current_user:)
    @current_user = current_user
    @step_summary = onboarding_steps_summary
    @step_urls = onboarding_steps_urls
  end

  private

  attr_reader :current_user

  def onboarding_steps_summary
    default_steps = { 'step_one' => 'false', 'step_two' => 'false', 'step_three' => 'false', 'step_four' => 'false' }
    summary = default_steps.merge(current_user.community_onboarding_steps).values
    current_index = summary.index('false')
    summary[current_index] = 'current' if current_index
    summary
  end

  def onboarding_steps_urls
    [
      { title: 'Community Rules', path: '/community_rules' },
      { title: 'How to Help Yourself Before Asking Others', path: '/before_asking' },
      { title: 'How to Ask Technical Questions', path: '/how_to_ask' },
      { title: 'Additional Community Expectations', path: '/community_expectations' }
    ]
  end
end
