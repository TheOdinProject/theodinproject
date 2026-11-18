module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # Streams are authorized by Turbo's signed stream names, so we identify the
    # user when Warden has one but don't reject anonymous connections.
    def connect
      self.current_user = env['warden']&.user
    end
  end
end
