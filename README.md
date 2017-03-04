# Sleep2

Ruby sleep with extra magical stuff.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sleep2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sleep2

## Usage

Don't forget to `require 'sleep2'` first.

### Do math with sleep.

```ruby
>> sleep = Sleep2.new(2) # no sleep when instantiating
#=> #<Sleep2:0x2afc2eaef970>
>> sleep # sleeps for 2 seconds
#=> #<Sleep2:0x2afc2eaef970>
>> sleep * 2 # sleeps twice longer than it should
#=> 4
>> sleep / 2 # sleeps half the time
#=> 1
>> sleep ** 2 # sleeps for 8 seconds
#=> 8
```

### Compare sleep with integer (in seconds) or another of its type

```ruby
>> sleep if sleep > 3 # not sleeping at all
#=> nil
>> freeze = Sleep2.new(3) # no sleep when instantiating
#=> #<Sleep2:0x2afc2eb138c0>
>> freeze > sleep ? freeze : sleep # sleeps for 3 seconds
#=> #<Sleep2:0x2afc2eb138c0>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/styd/sleep2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
