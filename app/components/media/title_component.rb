module Media
    class TitleComponent < ApplicationComponent
      with_collection_parameter :media
  
      def initialize(media:, classes: '')
          @media = media
          @classes = classes
      end
  
      private
  
      attr_reader :classes
    end
  end
  