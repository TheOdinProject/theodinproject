module Team
  class NavigationComponent < ApplicationComponent
    def initialize(roles:)
      @roles = roles
    end

    private

    attr_reader :roles
  end
end
