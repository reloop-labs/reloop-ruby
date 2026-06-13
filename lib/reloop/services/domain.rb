require_relative "../support/parameters"

module Reloop
  module Services
    class Domain
      def initialize(client)
        @client = client
      end

      def create(params)
        @client.fetch(
          :post,
          "/api/domain/v1/create",
          Support::Parameters.for_snake_request(params),
        )
      end

      def list(params = {})
        @client.fetch(
          :get,
          "/api/domain/v1/list",
          nil,
          Support::Parameters.for_query(params),
        )
      end

      def get(domain_id)
        @client.fetch(:get, "/api/domain/v1/#{domain_id}")
      end

      def get_nameservers(domain_id)
        @client.fetch(:get, "/api/domain/v1/nameservers/#{domain_id}")
      end

      def update(domain_id, params)
        @client.fetch(
          :patch,
          "/api/domain/v1/#{domain_id}",
          Support::Parameters.for_snake_request(params),
        )
      end

      def delete(domain_id)
        @client.fetch(:delete, "/api/domain/v1/#{domain_id}")
      end

      def verify(domain_id)
        @client.fetch(:post, "/api/domain/v1/verify/#{domain_id}")
      end

      def forward_dns(domain_id, params)
        @client.fetch(
          :post,
          "/api/domain/v1/verify/#{domain_id}/forward-dns",
          Support::Parameters.for_snake_request(params),
        )
      end
    end
  end
end
