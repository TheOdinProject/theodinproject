class User::LearningGoalComponent < ApplicationComponent
  def initialize(current_user:)
    @current_user = current_user
  end

  def learning_goal
    current_user.learning_goal.presence || settings_link
  end

  private

  attr_reader :current_user

  def settings_link
    link_to(
      "What's your learning goal?",
      edit_users_profile_path(learning_goal: true),
      class: 'text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-300 underline'
    )
  end
end
