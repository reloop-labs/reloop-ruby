module Reloop
  class Error < StandardError; end

  class Client
    attr_reader :api_key, :base_url

    def initialize(api_key:, base_url: "https://reloop.sh")
      raise ArgumentError, "Reloop SDK requires an api_key" if api_key.nil? || api_key.empty?

      @api_key = api_key
      @base_url = base_url
    end

    def fetch(method, path, body = nil, params = nil)
      conn = Faraday.new(url: @base_url) do |f|
        f.headers["x-api-key"] = @api_key
        f.headers["Content-Type"] = "application/json"
        f.headers["Accept"] = "application/json"
        f.adapter Faraday.default_adapter
      end

      response = conn.send(method) do |req|
        req.url path
        req.params = params if params
        req.body = body.to_json if body
      end

      unless response.success?
        error_body = begin
          JSON.parse(response.body)
        rescue StandardError
          {}
        end
        raise Error, "Reloop API Error: #{response.status} #{response.reason_phrase}. #{error_body}"
      end

      return {} if response.status == 204

      JSON.parse(response.body)
    end

    def api_keys
      @api_keys ||= Services::ApiKey.new(self)
    end

    def domain
      @domain ||= Services::Domain.new(self)
    end

    def contacts
      @contacts ||= Services::Contacts.new(self)
    end

    def mail
      @mail ||= Services::Mail.new(self)
    end
  end
end
