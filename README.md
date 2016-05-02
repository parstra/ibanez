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

## Info

Ibanez currently supports the following countries:

* Albania
* Andorra
* Austria
* Azerbaijan
* Bahrain
* Belgium
* Bosnia and Herzegovina
* Brazil
* Bulgaria
* Costa Rica
* Croatia
* Cyprus
* Czech Republic
* Denmark
* Dominican Republic
* East Timor
* Estonia
* Faroe Islands
* Finland
* France
* Georgia
* Germany
* Gibraltar
* Greece
* Greenland
* Guatemala
* Hungary
* Iceland
* Ireland
* Israel
* Italy
* Jordan
* Kazakhstan
* Kosovo
* Kuwait
* Latvia
* Lebanon
* Liechtenstein
* Lithuania
* Luxembourg
* Macedonia
* Malta
* Mauritania
* Mauritius
* Moldova
* Monaco
* Montenegro
* Netherlands
* Norway
* Pakistan
* Palestinian territories
* Poland
* Portugal
* Qatar
* Romania
* San Marino
* Saudi Arabia
* Serbia
* Slovakia
* Slovenia
* Spain
* Sweden
* Switzerland
* Tunisia
* Turkey
* United Arab Emirates
* United Kingdom
* Virgin Islands, British

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

