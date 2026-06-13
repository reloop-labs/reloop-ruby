require_relative "../support/parameters"

module Reloop
  module Services
    class ContactGroups
      def initialize(client)
        @client = client
      end

      def add_contact(group_id, params)
        @client.fetch(
          :post,
          "/api/contacts/group/#{group_id}",
          Support::Parameters.for_request(params),
        )
      end

      def remove_contact(group_id, params)
        @client.fetch(
          :delete,
          "/api/contacts/group/#{group_id}",
          Support::Parameters.for_request(params),
        )
      end

      def list_contacts(group_id, params = {})
        @client.fetch(
          :get,
          "/api/contacts/v1/groups/#{group_id}/contacts",
          nil,
          Support::Parameters.for_query(params),
        )
      end
    end
  end
end
