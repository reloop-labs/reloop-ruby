# Reloop Ruby SDK

Official Ruby client for the [Reloop](https://reloop.sh) API.

## Install

```bash
gem install reloop
```

Or add to your Gemfile:

```ruby
gem "reloop"
```

## Usage

```ruby
require "reloop"

reloop = Reloop::Client.new(api_key: "rl_your_api_key_here")
```

## Domains

Add, verify, and manage sending domains. Pass snake_case hash keys; responses are parsed JSON hashes from the API.

```ruby
reloop = Reloop::Client.new(api_key: "rl_your_api_key_here")

domain = reloop.domain.create(
  domain: "send.example.com",
  custom_return_path: "inbound",
  click_tracking: true,
  open_tracking: true,
  tls: "opportunistic",
  sending_email: true,
  receiving_email: true,
)

list = reloop.domain.list(page: 1, limit: 10, status: "active")

one = reloop.domain.get("domain_123456789")

reloop.domain.update(
  "domain_123456789",
  click_tracking: false,
  sending_email: true,
)

status = reloop.domain.verify("domain_123456789")

reloop.domain.forward_dns("domain_123456789", email: "admin@example.com")

nameservers = reloop.domain.get_nameservers("domain_123456789")
puts nameservers["dnsProvider"]

reloop.domain.delete("domain_123456789")
```

## API Keys

```ruby
reloop = Reloop::Client.new(api_key: "rl_your_api_key_here")

reloop.api_keys.create(name: "Production Key")
reloop.api_keys.list(page: 1, limit: 10, enabled: true)
reloop.api_keys.get("key_id_here")
reloop.api_keys.update("key_id_here", name: "Renamed Key")
reloop.api_keys.delete("key_id_here")
reloop.api_keys.rotate("key_id_here")
reloop.api_keys.pause("key_id_here")   # alias for disable
reloop.api_keys.disable("key_id_here")
reloop.api_keys.enable("key_id_here")
```

## Contacts

```ruby
reloop = Reloop::Client.new(api_key: "rl_your_api_key_here")

reloop.contacts.create(email: "user@example.com", first_name: "Ada", last_name: "Lovelace")
reloop.contacts.list(page: 1, limit: 10)
reloop.contacts.get("contact_id_here")
reloop.contacts.create_group(name: "Beta Testers")
reloop.contacts.create_property(property_name: "company", property_type: "string")
reloop.contacts.groups.add_contact("group_id_here", contact_id: "contact_id_here")
reloop.contacts.channels.add_contact("channel_id_here", contact_id: "contact_id_here")
```

## License

MIT
