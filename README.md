# Ibanez

Ibanez is a simple gem that facilitates international IBAN numbers validation.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ibanez'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ibanez

## Usage

#### Country helpers

* Get the supported countries

```ruby
Ibanez.supported_countries
#=> ['Greece', 'Italy']
```

* Check if a country is supported

```ruby
Ibanez.supports?('The Roman Empire')
#=> false
```

#### Validator

You can validate an IBAN as follows

```ruby
iban = Ibanez::Iban.new('GR73 0380 1150 0000 0000 1208 017')
iban.valid?
#=> true

english_iban = Ibanez::Iban.new('GB29 NWBK 6016 1331 9268 19', 'GB')
english_iban.valid?
#=> true

iban = Ibanez::Iban.new('GR73 0380 3350 1111 0000 1208 017')
iban.valid?
#=> false
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

