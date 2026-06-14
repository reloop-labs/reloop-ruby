# Contributing to the Reloop Ruby SDK

RubyGems package: **`reloop`**.

**License:** [Apache License 2.0](./LICENSE) with additional use restrictions from Reloop Labs.

**API reference:** [reloop.sh/docs](https://reloop.sh/docs)

Port new endpoints from the [Node.js SDK](https://github.com/reloop-labs/reloop-node) reference.

---

## Development setup

```bash
git clone git@github.com:reloop-labs/reloop-ruby.git
cd reloop-ruby
bundle install
ruby -Itest test/*_test.rb
```

Requires **Ruby 3.0+**.

---

## Project layout

```
lib/reloop/
  client.rb
  support/parameters.rb
  services/             # mail.rb, domain.rb, …
test/
reloop.gemspec          # version, includes LICENSE
```

---

## Conventions

| Topic | Rule |
|-------|------|
| Mail & domain | `Parameters.for_snake_request` |
| Contacts & API keys | `Parameters.for_request` |
| Tests | Stub `Client#fetch`; assert path and body hash |
| README | Minimal send example + link to docs |

---

## Pull request checklist

- [ ] All tests in `test/` pass
- [ ] `reloop.gemspec` version bumped only for releases

---

## Releasing

Version: **`reloop.gemspec`** → `spec.version`.

```bash
git commit -am "chore: release v1.9.0"
git push origin main
git tag v1.9.0
git push origin v1.9.0
```

[`.github/workflows/release.yml`](./.github/workflows/release.yml) uploads source zip + `.gem` file.

Publish: `gem push` via [`.github/workflows/publish.yml`](./.github/workflows/publish.yml).
