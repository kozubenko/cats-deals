require "rails_helper"

RSpec.describe ::ResponseHandler do
  let(:data) { {a: 1, b: 2, c: 3} }
  let(:json) { data.to_json }
  let(:xml) { data.to_xml(root: :resources) }

  let(:response) { Typhoeus::Response.new(body: json) }

  let(:options) { {} }
  let(:instance) { described_class.new(response, options) }

  describe "#parse" do
    subject { instance.parse }

    context "json response" do
      it "works correct" do
        expect(subject).to eq(data)
      end
    end

    context "xml response" do
      let(:options) { {parser: Parsers::XmlParser} }
      let(:response) { Typhoeus::Response.new(body: xml) }

      it "works correct" do
        expect(subject).to eq({resources: data})
      end
    end
  end
end
