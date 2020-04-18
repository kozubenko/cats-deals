require "rails_helper"

RSpec.describe Parsers::XmlParser do
  let(:data) { {a: 1} }
  let(:xml) { data.to_xml(root: :resources) }
  let(:instance) { described_class.new(xml) }

  describe "#run" do
    it do
      expect(instance.run).to eq({resources: data})
    end
  end
end
