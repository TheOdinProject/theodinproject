class ProgressCircle::LoadingComponent < ApplicationComponent
  def initialize(size: :default)
    @size = size
  end

  private

  attr_reader :size
end
