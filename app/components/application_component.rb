class ApplicationComponent < ViewComponent::Base
  include Turbo::FramesHelper

  class << self
    attr_reader :class_variants

    def style(&)
      @class_variants = ClassVariants.build(&)
    end
  end

  def classes_for(slot)
    self.class.class_variants.render(slot, type: variant)
  end
end
