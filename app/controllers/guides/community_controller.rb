module Guides
  class CommunityController < ApplicationController
    Guide = Data.define(:title, :path)

    def show
      @guides = guides.map { |title, path| Guide.new(title:, path:) }
    end

    private

    def guides
      {
        'Rules' => rules_guides_community_path,
        'Expectations' => expectations_guides_community_path,
        'How to Ask Technical Questions' => how_to_ask_guides_community_path,
        'Help Yourself Before Asking Others' => before_asking_guides_community_path
      }
    end
  end
end
