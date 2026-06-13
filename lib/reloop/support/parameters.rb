module Reloop
  module Support
    module Parameters
      REQUEST_KEY_MAP = {
        "first_name" => "firstName",
        "last_name" => "lastName",
        "group_ids" => "groupIds",
        "group_id" => "groupId",
        "fallback_value" => "fallbackValue",
        "default_subscription" => "defaultSubscription",
        "channel_id" => "channelId",
        "property_name" => "propertyName",
        "property_type" => "propertyType",
        "contact_id" => "contactId",
        "rate_limit_enabled" => "rateLimitEnabled",
        "user_id" => "userId",
      }.freeze

      def self.for_snake_request(params)
        params.each_with_object({}) do |(key, value), normalized|
          next if value.nil?

          normalized[key.to_s] = value
        end
      end

      def self.for_request(params)
        normalized = {}

        params.each do |key, value|
          if key.to_s == "unsubscribed"
            normalized["status"] = value ? "unsubscribed" : "subscribed" unless params.key?(:status) || params.key?("status")
            next
          end

          api_key = REQUEST_KEY_MAP[key.to_s] || to_camel_case(key.to_s)
          normalized[api_key] = normalize_value(value, for_request: true)
        end

        normalized.reject { |_, v| v.nil? }
      end

      def self.for_query(options)
        for_request(options)
      end

      def self.normalize_value(value, for_request:)
        return value unless value.is_a?(Hash)

        if value.keys.all? { |key| key.is_a?(Integer) }
          return value.map { |item| item.is_a?(Hash) ? normalize_value(item, for_request: for_request) : item }
        end

        for_request ? for_request(value) : value
      end

      def self.to_camel_case(key)
        return REQUEST_KEY_MAP[key] if REQUEST_KEY_MAP.key?(key)
        return key unless key.include?("_")

        parts = key.split("_")
        parts.first + parts.drop(1).map(&:capitalize).join
      end
      private_class_method :normalize_value, :to_camel_case
    end
  end
end
