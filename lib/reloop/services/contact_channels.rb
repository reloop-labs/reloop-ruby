require_relative "../support/parameters"

module Reloop
  module Services
    class ContactChannels
      def initialize(client)
        @client = client
      end

      def create(params)
        @client.fetch(
          :post,
          "/api/contacts/v1/channels/create",
          Support::Parameters.for_request(params),
        )
      end

      def list(params = {})
        @client.fetch(
          :get,
          "/api/contacts/v1/channels/list",
          nil,
          Support::Parameters.for_query(params),
        )
      end

      def get(channel_id)
        @client.fetch(:get, "/api/contacts/v1/channels/#{channel_id}")
      end

      def update(channel_id, params)
        @client.fetch(
          :patch,
          "/api/contacts/v1/channels/#{channel_id}",
          Support::Parameters.for_request(params),
        )
      end

      def delete(channel_id)
        @client.fetch(:delete, "/api/contacts/v1/channels/#{channel_id}")
      end

      def add_contact(channel_id, params)
        @client.fetch(
          :post,
          "/api/contacts/channel/#{channel_id}",
          Support::Parameters.for_request(params),
        )
      end

      def update_subscription(channel_id, params)
        @client.fetch(
          :patch,
          "/api/contacts/channel/#{channel_id}",
          Support::Parameters.for_request(params),
        )
      end
    end
  end
end
