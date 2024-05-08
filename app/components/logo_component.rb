class LogoComponent < ApplicationComponent
  def initialize(classes:, path: nil)
    @classes = classes
    @path = path
  end

  attr_reader :classes

  def redirect_to_path
    @path || root_path
  end
end
