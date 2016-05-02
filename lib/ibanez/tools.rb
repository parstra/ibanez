require 'nokogiri'
require 'open-uri'

module Ibanez
  module Tools
    # Fetches the configuration settings that are described in wikipedia
    def self.fetch_yml

      results = []

      wiki_doc = Nokogiri::HTML(
        open('https://en.wikipedia.org/wiki/International_Bank_Account_Number')
      )

      wiki_doc.css('table.wikitable.sortable').first.css('tr td').each_slice(5) do |country_line|
        country_line.map!(&:content)
        format = country_line[2].split(',').map { |ff| Hash[ff.slice!(-1,1), ff.to_i] }

        results << [
          country_line[3].slice(0,2),
          Hash[
            'name', country_line[0].gsub(/\s*\[.*\]/, ''),
            'length', country_line[1].to_i,
            'format', format
          ]
        ]
      end

      puts Hash[results.sort].to_yaml
    end
  end
end
