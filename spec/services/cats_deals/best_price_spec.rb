require 'rails_helper'

RSpec.describe CatsDeals::BestPrice do
  let(:params) { {type: 'type1', location: 'odessa'} }

  let(:deal1) { {type: 'type1', location: 'odessa', price: 50} }
  let(:deal2) { {type: 'type2', location: 'lviv', price: 10} }
  let(:deal3) { {type: 'type1', location: 'odessa', price: 20} }

  let(:collection) { [deal1, deal2, deal3] }

  let(:instance) { described_class.new(collection, params) }

  describe '#run' do
    subject { instance.send(:run) }

    it 'works correct' do
      expect(subject).to eq([deal3, deal1])
    end
  end

  describe '#filter_collection' do
    subject { instance.send(:filter_collection, collection) }

    it 'works correct' do
      expect(subject.length).to eq(2)
      expect(subject).to eq([deal1, deal3])
    end
  end

  describe '#compare_strings' do
    subject { instance.send(:compare_strings, string1, string2) }

    let(:string1) { FFaker::Lorem.word }
    let(:string2) { string1 }

    it 'works correct' do
      expect(subject).to be_truthy
    end

    context 'when different cases' do
      let(:string2) { string1.capitalize }

      it 'works correct' do
        expect(subject).to be_truthy
      end
    end

    context 'when strings are not equal' do
      let(:string2) { "#{string1}1" }

      it 'works correct' do
        expect(subject).to be_falsey
      end
    end

    context 'when some string is nil' do
      let(:string2) { nil }

      it 'works correct' do
        expect(subject).to be_falsey
      end
    end

    context 'when both strings is nil' do
      let(:string1) { nil }

      it 'works correct' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#sort_by_price' do
    subject { instance.send(:sort_by_price, collection) }

    it 'works correct' do
      expect(subject).to eq([deal2, deal3, deal1])
    end
  end
end
