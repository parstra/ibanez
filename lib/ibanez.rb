require 'ibanez/version'
require 'ibanez/iban/validator'
require 'ibanez/iban'
require 'yaml'

module Ibanez

  # Fetches all countries iban settings
  #
  # @return [Hash] of the settings
  def self.countries_settings
    if @countries_settings.nil?
      config_file = File.expand_path('../../config/iban_country_formats.yml', __FILE__)
      @countries_settings = YAML.load_file(config_file)
    end

    @countries_settings
  end

  # Fetches a country's iban settings
  # @param country[String] the given country
  #
  # @return [Hash] of a country's settings
  def self.country_settings(country = 'GR')
    return countries_settings[country] if countries_settings[country]

    raise UnknownCountryException.new("Unknown country: #{country}")
  end


  class UnknownCountryException < StandardError; end
end
