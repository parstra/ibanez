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

  # Fetches the supported countries
  #
  # @return [Array<String>] with countries
  def self.supported_countries
    countries_settings.map { |_, country_attributes| country_attributes['name'] }.sort
  end

  # Determines if a country is supported
  # @param country[String] the given country's code or name
  #
  # @return [Boolean]
  def self.supports?(country)
    countries_settings.keys.include?(country.to_s) || supported_countries.include?(country.to_s)
  end

  class UnknownCountryException < StandardError; end
end
