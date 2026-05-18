module Reloop
  module Services
    class ApiKey
      def initialize(client)
        @client = client
      end

      def create(params)
        @client.fetch(:post, "/api-key/v1/", params)
      end

      def list(params = nil)
        @client.fetch(:get, "/api-key/v1/", nil, params)
      end

      def get(id)
        @client.fetch(:get, "/api-key/v1/#{id}")
      end

      def update(id, params)
        @client.fetch(:patch, "/api-key/v1/#{id}", params)
      end

      def delete(id)
        @client.fetch(:delete, "/api-key/v1/#{id}")
      end

      def rotate(id)
        @client.fetch(:post, "/api-key/v1/rotate/#{id}")
      end

      def enable(id)
        @client.fetch(:post, "/api-key/v1/enable/#{id}")
      end

      def disable(id)
        @client.fetch(:post, "/api-key/v1/disable/#{id}")
      end
    end
  end
end
