require "minitest/autorun"
require_relative "../lib/reloop"

class ContactsServicePathsTest < Minitest::Test
  def setup
    @client = Reloop::Client.new(api_key: "rl_test", base_url: "https://reloop.sh")
    @contacts = Reloop::Services::Contacts.new(@client)
  end

  def test_create_uses_contacts_create_route
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:method] = method
      captured[:path] = path
      captured[:body] = body
      { "id" => "con_1" }
    end

    @contacts.create(email: "user@example.com", first_name: "Ada")

    assert_equal :post, captured[:method]
    assert_equal "/api/contacts/create", captured[:path]
    assert_equal(
      { "email" => "user@example.com", "firstName" => "Ada" },
      captured[:body],
    )
  end

  def test_get_uses_retrieve_route
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:path] = path
      {}
    end

    @contacts.get("con_1")

    assert_equal "/api/contacts/retrieve/con_1", captured[:path]
  end

  def test_list_with_group_id_delegates_to_groups
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:path] = path
      captured[:params] = params
      {}
    end

    @contacts.list(group_id: "grp_1", page: 1)

    assert_equal "/api/contacts/v1/groups/grp_1/contacts", captured[:path]
    assert_equal({ "page" => 1 }, captured[:params])
  end

  def test_channels_add_contact_uses_channel_route
    captured = {}
    @client.define_singleton_method(:fetch) do |method, path, body = nil, params = nil|
      captured[:method] = method
      captured[:path] = path
      {}
    end

    @contacts.channels.add_contact("ch_1", contact_id: "con_1")

    assert_equal :post, captured[:method]
    assert_equal "/api/contacts/channel/ch_1", captured[:path]
  end
end
