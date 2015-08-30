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
        config_file = File.expand_path('../../../../config/iban_country_formats.yml', __FILE__)
        if settings = YAML.load_file(config_file)[iban.country]
          @length = settings['length']
          @format = settings['format']
        else
          raise SettingsError.new("Unknown coutry: #{iban.country}")
        end
      end

      def valid_number?
        a_ord = 'A'.ord
        iban.number.partition(/.{4}/).reverse.join.
          gsub(/[A-Z]/) { |char| char.ord - a_ord + 10 }.
          to_i % 97 == 1
      end
    end

    class SettingsError < StandardError; end
  end
end
