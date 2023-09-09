module Team
  class FormerMemberComponent < ApplicationComponent
    FormerTeamMember = Data.define(:name, :image, :url)

    def initialize(team_member)
      @team_member = FormerTeamMember.new(**team_member)
    end

    private

    attr_reader :team_member
  end
end
