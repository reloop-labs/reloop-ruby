require "minitest/autorun"
require_relative "../lib/reloop"

class DomainParametersTest < Minitest::Test
  def test_for_snake_request_keeps_snake_case
    payload = Reloop::Support::Parameters.for_snake_request(
      domain: "send.example.com",
      click_tracking: true,
      custom_return_path: "inbound",
      ignored: nil,
    )

    assert_equal(
      {
        "domain" => "send.example.com",
        "click_tracking" => true,
        "custom_return_path" => "inbound",
      },
      payload,
    )
    refute payload.key?("clickTracking")
  end

  def test_for_query_omits_nil_values
    query = Reloop::Support::Parameters.for_query(
      page: 2,
      limit: 5,
      status: "active",
      q: nil,
    )

    assert_equal(
      {
        "page" => 2,
        "limit" => 5,
        "status" => "active",
      },
      query,
    )
  end
end

class DomainServicePathsTest < Minitest::Test
  def setup
    @client = Reloop::Client.new(api_key: "rl_test", base_url: "https://reloop.sh")
    @domain = Reloop::Services::Domain.new(@client)
  end

  def test_create_posts_to_domain_create_route
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:method] = method
      captured[:path] = path
      captured[:body] = body
      { "id" => "dom_1" }
    end

    result = @domain.create(domain: "send.example.com", click_tracking: true)

    assert_equal :post, captured[:method]
    assert_equal "/api/domain/v1/create", captured[:path]
    assert_equal(
      { "domain" => "send.example.com", "click_tracking" => true },
      captured[:body],
    )
    assert_equal "dom_1", result["id"]
  end

  def test_get_nameservers_uses_nameservers_route
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:method] = method
      captured[:path] = path
      { "dnsProvider" => "cloudflare" }
    end

    @domain.get_nameservers("dom_1")

    assert_equal :get, captured[:method]
    assert_equal "/api/domain/v1/nameservers/dom_1", captured[:path]
  end

  def test_forward_dns_uses_forward_dns_route
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:method] = method
      captured[:path] = path
      captured[:body] = body
      { "success" => true }
    end

    @domain.forward_dns("dom_1", email: "admin@example.com")

    assert_equal :post, captured[:method]
    assert_equal "/api/domain/v1/verify/dom_1/forward-dns", captured[:path]
    assert_equal({ "email" => "admin@example.com" }, captured[:body])
  end
end
