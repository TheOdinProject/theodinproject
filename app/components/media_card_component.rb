class MediaCardComponent < ApplicationComponent
  with_collection_parameter :media
  
  renders_one :image, Media::ImageComponent
  renders_one :title, Media::TitleComponent
  renders_one :description, Media::DescriptionComponent

  def initialize(media:, classes: '')
    @media = media
    @classes = classes
  end

  private

  attr_reader :classes
end
