require_relative "../support/parameters"

module Reloop
  module Services
    class Mail
      def initialize(client)
        @client = client
      end

      def send(params)
        @client.fetch(
          :post,
          "/api/mail/v1/send",
          Support::Parameters.for_snake_request(params),
        )
      end
    end
  end
end
