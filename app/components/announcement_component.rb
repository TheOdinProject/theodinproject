class AnnouncementComponent < ApplicationComponent
  def initialize(announcement:)
    @announcement = announcement
  end

  def render?
    announcement.present?
  end

  private

  attr_reader :announcement
end
