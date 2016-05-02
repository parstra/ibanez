require 'spec_helper'

describe Ibanez do
  it 'has a version number' do
    expect(Ibanez::VERSION).not_to be nil
  end

  describe '.countries_settings' do
    subject { Ibanez.countries_settings }

    it 'is a hash' do
      expect(subject).to be_a(Hash)
    end

    it 'contains data' do
      expect(subject).to_not be_empty
    end

    Ibanez.countries_settings.each do |country, attributes|
      subject { attributes }

      context "for country: '#{country}'" do
        it 'has a country name' do
          expect(subject['name']).to be_a(String)
        end

        it 'has a length' do
          expect(subject['length']).to be_a(Integer)
        end

        context 'the format' do
          subject(:format) { attributes['format'] }

          it 'is present' do
            expect(format).to be_a(Array)
          end

          it 'has valid structure' do
            expect(format.all? { |f| f.keys.length == 1 && f.values.length == 1 }).to be true
          end

          it 'has valid keys (a, n, c)' do
            expect(format.all? { |f| f.keys.all? { |k| ['a', 'n', 'c'].include? k } }).to be true
          end

          it 'has valid values' do
            expect(format.all? { |f| f.values.all? { |v| v.is_a?(Integer) } } ).to be true
          end
        end
      end
    end
  end

  describe '.country_settings' do
    context 'when the country is missing' do
      it 'raises an UnknowCountryException on unknown country' do
        expect { Ibanez.country_settings('ZERGOVIA') }.
          to raise_error(Ibanez::UnknownCountryException, /Unknown country/)
      end
    end

    it 'returns a county\'s settings' do
      expect(Ibanez.country_settings('GR')).
        to eq({"name"=>"Greece", "length"=>27, "format"=>[{"n"=>7}, {"c"=>16}]})
    end
  end

  describe '.supported_countries' do
end
