require 'rails_helper'

RSpec.describe ::ResponseHandler do
  let(:data) { {a: 1, b: 2, c: 3} }
  let(:json) { data.to_json }
  let(:xml) { data.to_xml(root: :resources) }

  let(:response) { Typhoeus::Response.new(body: json) }

  let(:parser) { ::Parsers::JsonParser }

  let(:instance) { described_class.new(response, parser) }

  describe '#parse' do
    subject { instance.parse }

    context 'when got json response' do
      it 'works correct' do
        expect(subject).to eq(data)
      end
    end

    context 'when got xml response' do
      let(:parser) { ::Parsers::XmlParser }
      let(:response) { Typhoeus::Response.new(body: xml) }

      it 'works correct' do
        expect(subject).to eq(resources: data)
      end
    end
  end
end
