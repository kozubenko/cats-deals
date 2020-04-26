require 'rails_helper'

RSpec.describe RemoteServices::FetchCollections do
  include_examples 'fetch api'

  describe '#run' do
    context 'when use cats deals source' do
      subject { instance.send(:run) }

      let(:factory) { ::ApiSources::CatsDeals::SourcesFactory }

      let(:xml_api_key) { FFaker::Internet.uri('https') }
      let(:json_api_key) { FFaker::Internet.uri('https') }

      let(:xml_response) do
        {cat: [{title: 'name2', cost: 10, location: 'location2', img: 'image2'}]}.to_xml(root: :cats)
      end

      let(:json_response) { [{name: 'name1', price: 5, location: 'location1', image: 'image1'}].to_json }

      let(:response) do
        [
          {type: 'name2', price: 10, location: 'location2', image: 'image2'},
          {type: 'name1', price: 5, location: 'location1', image: 'image1'}
        ]
      end

      it 'works correct' do
        stub_request(:get, xml_api_key).to_return(body: xml_response, status: 200)
        stub_request(:get, json_api_key).to_return(body: json_response, status: 200)

        expect(ENV).to receive(:[]).with('HAPPY_CATS_API_URL').and_return(xml_api_key)
        expect(ENV).to receive(:[]).with('UNLIMITED_CATS_API_URL').and_return(json_api_key)

        expect(subject).to contain_exactly(*response)
      end
    end
  end

  describe '#add_to_storage' do
    response = [1, 2, 3]
    subject { instance.send(:add_to_storage, response) }

    it 'works correct' do
      expect(subject).to eq(response)
    end
  end
end
