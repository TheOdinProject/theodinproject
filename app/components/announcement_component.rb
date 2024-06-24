class AnnouncementComponent < ApplicationComponent
  def initialize(announcement:, closeable: true)
    @announcement = announcement
    @closeable = closeable
  end

  def render?
    announcement.present?
  end

  private

  attr_reader :announcement, :closeable
end
