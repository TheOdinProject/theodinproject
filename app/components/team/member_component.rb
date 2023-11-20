module Team
  class MemberComponent < ApplicationComponent
    Social = Data.define(:name, :url)

    TeamMember = Data.define(:name, :image, :location, :joined, :socials) do
      def initialize(**args)
        socials = args.fetch(:socials, []).map { |social| Social.new(**social) }
        location = args.fetch(:location, '')

        super(**args.merge(location:, socials:))
      end
    end

    def initialize(team_member)
      @team_member = TeamMember.new(**team_member)
    end

    def member_metadata
      return "Joined #{team_member.joined}" if team_member.location.blank?

      "Joined #{team_member.joined} &centerdot; #{team_member.location}"
    end

    private

    attr_reader :team_member
  end
end
