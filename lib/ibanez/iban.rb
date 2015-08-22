module Ibanez
  class Iban
    COUNTRY = 'GR'
    LENGTH = 27
    FORMAT = { n: 7, c: 16 }

    attr_reader :iban

    def initialize(iban)
      @iban = iban.to_s.gsub(/\s+/,'').upcase
    end

    def valid?
      iban.length == LENGTH && valid_format? && to_i % 97 == 1
    end

    private

    def valid_length?
      iban.length == LENGTH
    end

    def valid_format?
      regs = { n: "\\d", a: "[a-zA-Z]", c: "\\w" }
      country_reg = "^#{FORMAT.map { |t, c| "#{regs[t]}{#{c}}"}.join}$"
      !iban.slice(4, LENGTH - 4).match(/#{country_reg}/).nil?
    end

    def to_i
      a_ord = 'A'.ord
      z_ord = 'Z'.ord

      iban_i = @iban.dup
      iban_i << iban_i.slice!(0,4)
      iban_i.split(//).map do |digit|
        if (a_ord..z_ord).include? digit.ord
          digit.ord - a_ord + 10
        else
          digit
        end
      end.join.to_i
    end
  end
end
