class MediaCardComponent < ApplicationComponent
  with_collection_parameter :media
  
  renders_one :image, -> do
   Media::ImageComponent.new(media: @media)
  end
  renders_one :title, -> do
    Media::TitleComponent.new(media: @media)
  end
  renders_one :description, -> do 
    Media::DescriptionComponent.new(media: @media)
  end

  def initialize(media:, classes: '')
    @media = media
    @classes = classes
  end

  private

  attr_reader :classes
end
