module Team
  class MemberComponent < ViewComponent::Base
    TeamMember = Struct.new(
      :name, :image, :twitter, :github, :linkedin, :website, keyword_init: true
    )

    def initialize(team_member:)
      @team_member = TeamMember.new(team_member)
    end

    private

    attr_reader :team_member
  end
end
