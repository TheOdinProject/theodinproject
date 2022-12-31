class DividerComponent < ApplicationComponent
  def initialize(message: nil)
    @message = message
  end

  private

  attr_reader :message
end
