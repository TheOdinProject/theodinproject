module Oauth
  class ConnectButtonComponent < ApplicationComponent
    with_collection_parameter :provider
    delegate :omniauth_authorize_path, to: :helpers

    def initialize(provider:, resource_name:)
      @provider = provider
      @resource_name = resource_name
    end

    private

    attr_reader :provider, :resource_name
  end
end
