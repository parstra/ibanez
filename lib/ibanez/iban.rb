module Ibanez
  class Iban

    attr_reader :number, :country

    def initialize(iban_string, country = 'GR')
      @number = iban_string.to_s.gsub(/\s+/,'').upcase
      @country = country
    end

    # Determines if an IBAN is valid
    #
    # @return [Boolean]
    def valid?
      Validator.new(self).valid?
    end

    # Provides a human readable IBAN number
    #
    # @return [String]
    def to_s
      number
    end
  end
end
