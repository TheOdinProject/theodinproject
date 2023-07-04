class Media::MediaComponent < ApplicationComponent
  with_collection_parameter :media

  def initialize(media:)
    @media = media
  end
end
