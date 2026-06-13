require_relative "../support/parameters"
require_relative "contact_groups"
require_relative "contact_channels"

module Reloop
  module Services
    class Contacts
      attr_reader :groups, :channels

      def initialize(client)
        @client = client
        @groups = ContactGroups.new(client)
        @channels = ContactChannels.new(client)
      end

      def create(params)
        @client.fetch(
          :post,
          "/api/contacts/create",
          Support::Parameters.for_request(params),
        )
      end

      def get(contact_id)
        @client.fetch(:get, "/api/contacts/retrieve/#{contact_id}")
      end

      def list(params = {})
        query = Support::Parameters.for_query(params)
        group_id = query["groupId"] || query["group_id"]

        if group_id
          filtered = query.reject { |key, _| %w[groupId group_id].include?(key) }
          return @groups.list_contacts(group_id, filtered)
        end

        @client.fetch(:get, "/api/contacts/list", nil, query)
      end

      def update(contact_id, params)
        @client.fetch(
          :patch,
          "/api/contacts/#{contact_id}",
          Support::Parameters.for_request(params),
        )
      end

      def delete(contact_id)
        @client.fetch(:delete, "/api/contacts/#{contact_id}")
      end

      def create_property(params)
        @client.fetch(
          :post,
          "/api/contacts/v1/properties/create",
          Support::Parameters.for_request(params),
        )
      end

      def list_properties(params = {})
        @client.fetch(
          :get,
          "/api/contacts/v1/properties/list",
          nil,
          Support::Parameters.for_query(params),
        )
      end

      def update_property(property_id, params)
        @client.fetch(
          :patch,
          "/api/contacts/v1/properties/#{property_id}",
          Support::Parameters.for_request(params),
        )
      end

      def delete_property(property_id)
        @client.fetch(:delete, "/api/contacts/v1/properties/#{property_id}")
      end

      def create_group(params)
        @client.fetch(
          :post,
          "/api/contacts/v1/groups/create",
          Support::Parameters.for_request(params),
        )
      end

      def list_groups(params = {})
        @client.fetch(
          :get,
          "/api/contacts/v1/groups/list",
          nil,
          Support::Parameters.for_query(params),
        )
      end

      def get_group(group_id)
        @client.fetch(:get, "/api/contacts/v1/groups/#{group_id}")
      end

      def update_group(group_id, params)
        @client.fetch(
          :patch,
          "/api/contacts/v1/groups/#{group_id}",
          Support::Parameters.for_request(params),
        )
      end

      def delete_group(group_id)
        @client.fetch(:delete, "/api/contacts/v1/groups/#{group_id}")
      end
    end
  end
end
