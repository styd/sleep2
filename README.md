# Sleep2 [![Build Status](https://travis-ci.org/styd/sleep2.svg?branch=master)](https://travis-ci.org/styd/sleep2)

Ruby sleep with extra magical stuff. These extra stuff will be useful when you
are developing an algorithm with some kind of delay patterns such as in
animation.

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
>> sleep = Sleep2[2] # no sleep when instantiating
#=> #<Sleep2:0x2afc2eaef970>
>> sleep # sleeps for 2 seconds
#=> #<Sleep2:0x2afc2eaef970>
>> delay = sleep * 2 # instantiate new sleep object (therefore no sleeping yet)
#=> #<Sleep2:0x2afc217b09d0>
>> delay # sleeps twice longer than sleep
#=> #<Sleep2:0x2afc217b09d0>
```

### Compare sleep with integer (in seconds) or another of its type

```ruby
>> sleep if sleep > 3 # not sleeping at all since sleep duration is 2 seconds
#=> nil
>> delay = Sleep2[3] # no sleep when instantiating
#=> #<Sleep2:0x2afc2eb138c0>
>> delay > sleep ? delay : sleep # sleeps for 3 seconds
#=> #<Sleep2:0x2afc2eb138c0>
```

### Change current instance duration

```ruby
>> freeze = Sleep2[3] # no sleep when instantiating
#=> #<Sleep2:0x2afc2262c2c0>
>> freeze[4] # no sleep when changing duration
#=> 4.0
>> freeze # sleeps for 4 seconds
#=> #<Sleep2:0x2afc2262c2c0>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/styd/sleep2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
