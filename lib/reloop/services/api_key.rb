require_relative "../support/parameters"

module Reloop
  module Services
    class ApiKey
      def initialize(client)
        @client = client
      end

      def create(params)
        @client.fetch(:post, "/api/api-key/v1/", params)
      end

      def list(params = {})
        @client.fetch(
          :get,
          "/api/api-key/v1/",
          nil,
          Support::Parameters.for_query(params),
        )
      end

      def get(id)
        @client.fetch(:get, "/api/api-key/v1/#{id}")
      end

      def update(id, params)
        @client.fetch(:patch, "/api/api-key/v1/#{id}", params)
      end

      def delete(id)
        @client.fetch(:delete, "/api/api-key/v1/#{id}")
      end

      def rotate(id)
        @client.fetch(:post, "/api/api-key/v1/rotate/#{id}")
      end

      def enable(id)
        @client.fetch(:post, "/api/api-key/v1/enable/#{id}")
      end

      def disable(id)
        @client.fetch(:post, "/api/api-key/v1/disable/#{id}")
      end

      def pause(id)
        disable(id)
      end
    end
  end
end
