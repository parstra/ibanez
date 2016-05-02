require 'spec_helper'

describe Ibanez::Iban do
  describe '#valid?' do
    it 'raises an UnknowCountryException on unknown country' do
      expect { Ibanez::Iban.new('1234', 'ZERGOVIA').valid? }.
        to raise_error(Ibanez::UnknownCountryException, /Unknown country/)
    end

    it 'validates valid IBAN' do
      ['GR73 0380 1150 0000 0000 1208 017', 'GR41 0140 2940 2940 0232 0000 587'].each do |iban|
        expect(Ibanez::Iban.new(iban)).to be_valid
      end
    end

    it 'does not validate IBAN with wrong checksum' do
      ['GR79 0380 1150 0000 0000 1208 017', 'GR41 0140 2940 2940 0232 0S00 587'].each do |iban|
        expect(Ibanez::Iban.new(iban)).not_to be_valid
      end
    end

    it 'does not validate IBAN with wrong length' do
      ['GR79 0380 115 0000 0000 1208 017', 'GR49 0140 2940 29400 0232 0000 587'].each do |iban|
        expect(Ibanez::Iban.new(iban)).not_to be_valid
      end
    end

    it 'does not validate IBAN with wrong format' do
      iban = Ibanez::Iban.new('GR73 0380 1A50 0000 0000 1208 017')
      expect(iban).not_to be_valid
    end

    context 'supported countries' do
      it 'validates GB IBAN' do
        iban = Ibanez::Iban.new('GB29 NWBK 6016 1331 9268 19', 'GB')
        expect(iban).to be_valid
      end

      it 'validates AL IBAN' do
        iban = Ibanez::Iban.new('AL47 2121 1009 0000 0002 3569 8741', 'AL')
        expect(iban).to be_valid
      end

      it 'validates AD IBAN' do
        iban = Ibanez::Iban.new('AD12 0001 2030 2003 5910 0100', 'AD')
        expect(iban).to be_valid
      end

      it 'validates AT IBAN' do
        iban = Ibanez::Iban.new('AT61 1904 3002 3457 3201', 'AT')
        expect(iban).to be_valid
      end
    end
  end
end
