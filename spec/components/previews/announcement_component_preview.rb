class AnnouncementComponentPreview < ViewComponent::Preview
  # @param message [String] text "The text to display in the announcement"
  def with_announcment(message: 'Hello!')
    render(AnnouncementComponent.new(announcement: default_announcment(message:)))
  end

  private

  def default_announcment(**opts)
    defaults = {
      expires_at: DateTime.tomorrow,
      user_id: 1,
      message: opts[:message]
    }

    Announcement.new(defaults)
  end
end
