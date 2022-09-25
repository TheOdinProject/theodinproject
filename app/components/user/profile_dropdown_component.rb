class User::ProfileDropdownComponent < ViewComponent::Base
  include Turbo::FramesHelper

  delegate :current_theme, to: :helpers

  def initialize(current_user:)
    @current_user = current_user
  end

  private

  attr_reader :current_user
end
