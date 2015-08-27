require 'spec_helper'

describe Ibanez::Iban do
  describe '#valid?' do
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

    it 'validates UK IBAN' do
      iban = Ibanez::Iban.new('GB29 NWBK 6016 1331 9268 19', 'UK')
      expect(iban).to be_valid
    end
  end
end
