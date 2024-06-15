class Flags::ActionButtonComponent < ApplicationComponent
  def initialize(flag:)
    @flag = flag
  end

  def render?
    @flag.active?
  end

  private

  attr_reader :flag
end
