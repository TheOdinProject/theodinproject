module Team
  class MemberComponent < ApplicationComponent
    Social = Data.define(:name, :url)

    TeamMember = Data.define(:name, :image, :location, :joined, :socials) do
      def initialize(**args)
        socials = args.fetch(:socials, []).map { |social| Social.new(**social) }
        super(**args.merge(socials:))
      end
    end

    def initialize(team_member)
      @team_member = TeamMember.new(**team_member)
    end

    private

    attr_reader :team_member
  end
end
