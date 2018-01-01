require 'json'

module Gitter
  class Client
    include HTTParty
  
    base_uri 'https://api.gitter.im/v1'

    def initialize(token:)
      @token = token
    end

    def send_message(text:, room_id:)
      self.class.post(
        "/rooms/#{room_id}/chatMessages",
        headers: headers,
        body: { text: text }.to_json
      )
    end

    private

    attr_reader :token

    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{token}"
      }
    end
  end
end