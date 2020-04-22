require "rails_helper"

RSpec.describe RemoteServices::FetchCollectionsApi do
  include_examples "fetch api"

  describe "#run" do
    context "cats deals api" do
      let(:factory) { ::ApiSources::CatsDeals::SourcesFactory }

      let(:xml_api_key) { FFaker::Internet.uri("https") }
      let(:json_api_key) { FFaker::Internet.uri("https") }

      let(:xml_response) do
        {cat: [{title: "name2", cost: 10, location: "location2", img: "image2"}]}.to_xml(root: :cats)
      end

      let(:json_response) { [{name: "name1", price: 5, location: "location1", image: "image1"}].to_json }

      let(:response) do
        [
          {name: "name2", price: 10, location: "location2", image: "image2"},
          {name: "name1", price: 5, location: "location1", image: "image1"}
        ]
      end

      subject { instance.send(:fetch) }

      it "works correct" do
        stub_request(:get, json_api_key).to_return(body: json_response, status: 200)
        stub_request(:get, xml_api_key).to_return(body: xml_response, status: 200)

        allow(ENV).to receive(:[]).with("HAPPY_CATS_API_URL").and_return(xml_api_key)
        allow(ENV).to receive(:[]).with("UNLIMITED_CATS_API_URL").and_return(json_api_key)

        subject
        expect(instance.storage).to eq(response)
      end
    end
  end

  describe "#add_to_storage" do
    response = [1, 2, 3]
    subject { instance.send(:add_to_storage, response) }

    it "works correct" do
      expect(subject).to eq(response)
    end
  end
end
