class ProgressCircle::LoadingComponent < ApplicationComponent
  style do
    variant type: :default do
      slot :container_size, class: 'h-24 w-24 sm:h-28 sm:w-28'
    end

    variant type: :small do
      slot :container_size, class: 'h-24 w-24'
    end
  end

  def initialize(size: :default)
    @size = size
  end

  def variant
    size
  end

  private

  attr_reader :size
end
