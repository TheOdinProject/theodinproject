module Card
  class HeaderComponent < ApplicationComponent
    def initialize(classes: '')
      @classes = classes
    end

    private

    attr_reader :classes
  end
end
