require "minitest/autorun"
require_relative "../lib/reloop"

class ApiKeyServicePathsTest < Minitest::Test
  def setup
    @client = Reloop::Client.new(api_key: "rl_test", base_url: "https://reloop.sh")
    @api_keys = Reloop::Services::ApiKey.new(@client)
  end

  def test_create_uses_api_prefix
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:method] = method
      captured[:path] = path
      { "id" => "key_1" }
    end

    @api_keys.create(name: "Production Key")

    assert_equal :post, captured[:method]
    assert_equal "/api/api-key/v1/", captured[:path]
  end

  def test_rotate_uses_rotate_route
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:path] = path
      { "key" => "rl_live_secret" }
    end

    @api_keys.rotate("key_1")

    assert_equal "/api/api-key/v1/rotate/key_1", captured[:path]
  end

  def test_pause_delegates_to_disable
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:method] = method
      captured[:path] = path
      { "enabled" => false }
    end

    @api_keys.pause("key_1")

    assert_equal :post, captured[:method]
    assert_equal "/api/api-key/v1/disable/key_1", captured[:path]
  end
end
