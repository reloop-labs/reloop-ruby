# Reloop Ruby SDK

## Before you send

You need two things:

1. **API key** — create one in your Reloop account
2. **Verified domain** — add and verify a sending domain; use it in the `from` address

For setup details and the full API reference, see [reloop.sh/docs](https://reloop.sh/docs).

## Send email

```bash
gem install reloop
```

```ruby
require "reloop"

reloop = Reloop::Client.new(api_key: "rl_your_api_key_here")

result = reloop.mail.send(
  from: "Reloop <hello@your-verified-domain.com>",
  to: "user@example.com",
  subject: "Welcome to Reloop",
  html: "<p>Thanks for signing up.</p>",
  text: "Thanks for signing up.",
)

puts result["messageId"], result["id"]
```

More examples and optional fields: [reloop.sh/docs](https://reloop.sh/docs)
