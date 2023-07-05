module Media
  class ImageComponent < ApplicationComponent

    def initialize(media:, classes: '')
        @media = media
        @classes = classes
    end

    private

    attr_reader :classes
  end
end
