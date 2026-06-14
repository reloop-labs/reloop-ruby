require "minitest/autorun"
require_relative "../lib/reloop"

class MailServicePathsTest < Minitest::Test
  def setup
    @client = Reloop::Client.new(api_key: "rl_test", base_url: "https://reloop.sh")
    @mail = Reloop::Services::Mail.new(@client)
  end

  def test_send_posts_to_mail_send_route
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:method] = method
      captured[:path] = path
      captured[:body] = body
      {
        "success" => true,
        "messageId" => "msg_123456789",
        "status" => "sent",
        "timestamp" => "2026-01-01T00:00:00.000Z",
        "id" => "log_123456789",
      }
    end

    result = @mail.send(
      from: "Reloop <hello@send.example.com>",
      to: "user@example.com",
      subject: "Welcome to Reloop",
      reply_to: "support@example.com",
      tags: [{ name: "campaign", value: "welcome" }],
    )

    assert_equal :post, captured[:method]
    assert_equal "/api/mail/v1/send", captured[:path]
    assert_equal(
      {
        "from" => "Reloop <hello@send.example.com>",
        "to" => "user@example.com",
        "subject" => "Welcome to Reloop",
        "reply_to" => "support@example.com",
        "tags" => [{ "name" => "campaign", "value" => "welcome" }],
      },
      captured[:body],
    )
    assert_equal "msg_123456789", result["messageId"]
    assert_equal "log_123456789", result["id"]
  end
end
