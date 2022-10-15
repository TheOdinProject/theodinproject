class User::AvatarComponent < ApplicationComponent
  def initialize(current_user:, classes:)
    @current_user = current_user
    @classes = classes
  end

  private

  attr_reader :current_user, :classes
end
