# Haikunate

Generate Heroku-like memorable random names like `adorable-ox-1234`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "haikunate"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install haikunate

## Usage

You generate random haiku names by calling `Haikunate.call` (or its alias
`Haiku.call`).

```ruby
Haiku.call
#=> satisfied-eagle-7977
```

You can change the joiner string by provider the option `joiner`.

```ruby
Haiku.call(joiner: ".")
#=> passionate.alpaca.7619
```

A haiku composed by `adjective-noun-variant`, where variant is a random number
within `1000..9999` range. You can override the range by setting
`Haiku.default_range`.

```ruby
Haiku.default_range = 10_000..99_999
#=> abundant-panda-57702
```

Alternatively, you can provide a `variant` option, which can be any object that
responds to `.call()`.

```ruby
require "securerandom"

Haiku.call(variant: -> { SecureRandom.alphanumeric(5).downcase })
#=> tidy-skunk-s8ln0
```

To override the dictionary list, use `Haiku.adjectives=(list)` and
`Haiku.nouns=(list)`.

```ruby
Haiku.adjectives = %w[awful terrible crazy]
Haiku.nouns = %w[lawyer judge politian]

Haiku.call
#=> terrible-politian-8116
```

If you're planning to use a haiku as some unique value on your database, you can
use `Haiku.next(options, &block)`; a new haiku will be generated until
`block.call(haiku)` returns `false`. For instance, this is how you'd use it with
ActiveRecord:

```ruby
site = Site.new
site.slug = Haiku.next {|slug| Site.where(slug: slug).exists? }
site.save!
```

That can be a problem for databases with lots and lots of records. If that's the
case, you can then use a more random variant like 6 random alphanumeric
characters.

You can override the default variant generator by setting
`Haiku.default_variant=(new_variant)`.

```ruby
Haiku.default_variant = -> { SecureRandom.alphanumeric(6).downcase }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/fnando/haikunate. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/fnando/haikunate/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Haikunate project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/fnando/haikunate/blob/master/CODE_OF_CONDUCT.md).
