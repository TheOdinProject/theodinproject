module Guides
  class CommunityController < ApplicationController
    def show
      @guides = guides.map { |title, path| OpenStruct.new(title:, path:) } # rubocop:disable Style/OpenStructUse
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
