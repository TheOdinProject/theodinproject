module OmniauthProviders
  class Builder
    def initialize(auth, user)
      @auth = auth
      @user = user
    end

    def build
      UserProvider.create!(provider_attributes)
    end

    private

    attr_reader :auth, :user

    def provider_attributes
      {
        provider: auth.provider,
        uid: auth.uid,
        user_id: user.id
      }
    end
  end
end
