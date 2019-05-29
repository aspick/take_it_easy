# TakeItEasy

Take an ActiveRecord model, print seed code for the testing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'take_it_easy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install take_it_easy

## Usage

```ruby
irb> Book.find(12).take_it_easy
```
```text
let(:bookshelf) { create(:bookshelf, name: 'General') }
let(:book) { create(:book, name: 'Test book 1', bookshelf: bookshelf) }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/take_it_easy.
