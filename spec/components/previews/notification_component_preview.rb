class NotificationComponentPreview < ViewComponent::Preview
  # @!group
  # @display bg_color "#eee"
  def unread
    render(NotificationComponent.new(notification: unread_notification))
  end

  def read
    render(NotificationComponent.new(notification: read_notification))
  end

  private

  def unread_notification
    Notification.new(id: 1, title: 'test title', message: 'test message')
  end

  def read_notification
    Notification.new(id: 1, title: 'test title', message: 'test message', read_at: DateTime.yesterday)
  end
end
