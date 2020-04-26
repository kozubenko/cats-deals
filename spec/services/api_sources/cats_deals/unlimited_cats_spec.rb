require 'rails_helper'

RSpec.describe ApiSources::CatsDeals::UnlimitedCats do
  let(:instance) { described_class.new }

  describe '#handle_response' do
    subject { instance.send(:handle_response, 'response') }

    let(:parsed_response) { [] }

    it 'works correct' do # rubocop:disable RSpec/ExampleLength
      response = 'response'
      parser = ::Parsers::JsonParser
      handler = instance_double '::ResponseHandler', response: response, parser: parser

      expect(::ResponseHandler).to receive(:new).with('response', parser).and_return(handler)
      expect(handler).to receive(:parse).and_return(parsed_response)

      expect(subject).to eq([])
    end
  end

  describe '#options' do
    subject { instance.send(:options) }

    it 'works correct' do
      expect(subject).to eq({})
    end
  end

  describe '#fetch_url' do
    subject { instance.send(:fetch_url) }

    let(:api_key) { FFaker::Lorem.word }

    it 'works correct' do
      allow(ENV).to receive(:[]).with('UNLIMITED_CATS_API_URL').and_return(api_key)
      expect(subject).to eq(api_key)
    end
  end

  describe '#serialize' do
    subject { instance.send(:serialize, data) }

    let(:image_source) { FFaker::Internet.uri('http') }
    let(:price) { '10' }

    let(:data) { [{name: 'name2', price: price, location: 'location2', image: image_source}] }

    it 'works correct' do
      expect(subject).to eq([{cat_type: 'name2', price: price.to_i, location: 'location2', image: image_source}])
    end

    context 'when price is empty' do
      let(:price) { nil }

      it 'works correct' do
        expect(subject).to eq([{cat_type: 'name2', price: 0, location: 'location2', image: image_source}])
      end
    end
  end
end
