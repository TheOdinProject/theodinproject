class LogoComponent < ApplicationComponent
  def initialize(classes:)
    @classes = classes
  end

  attr_reader :theme, :classes
end
