class MediaCardComponent < ApplicationComponent
  Media = Data.define(:title, :description, :image_path)

  with_collection_parameter :media

  def initialize(media:)
    @media = Media.new(**media)
  end

  private

  attr_reader :media
end
