class Media::DescriptionComponent < ApplicationComponent
  def initialize(media:, classes: '')
    @media = media
    @classes = classes
  end

  private

  attr_reader :classes
end