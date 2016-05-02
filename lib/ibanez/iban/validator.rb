module Ibanez
  class Iban
    class Validator
      attr_reader :iban, :format, :length

      REGS = {
        'n' => '\\d',
        'a' => '[a-zA-Z]',
        'c' => '[a-zA-Z0-9]'
      }

      def initialize(iban)
        @iban = iban
        initialize_format
      end

      def valid?
        valid_length? && valid_format? && valid_number?
      end

      private

      def valid_length?
        iban.number.length == length
      end

      def valid_format?
        country_reg = ['^.{4}', format.map { |e| e.map{ |t, c| [REGS[t], "{#{c}}"]}}, '$'].join
        !iban.number.match(/^#{country_reg}$/).nil?
      end

      def initialize_format
        country_settings = Ibanez.country_settings(iban.country)

        @length = country_settings['length']
        @format = country_settings['format']
      end

      def valid_number?
        a_ord = 'A'.ord
        iban.number.partition(/.{4}/).reverse.join.
          gsub(/[A-Z]/) { |char| char.ord - a_ord + 10 }.
          to_i % 97 == 1
      end
    end
  end
end
