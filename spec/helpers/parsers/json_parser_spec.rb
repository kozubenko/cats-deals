require "rails_helper"

RSpec.describe Parsers::JsonParser do
  let(:data) { {a: 1} }
  let(:json) { data.to_json }
  let(:instance) { described_class.new(json) }

  describe "#run" do
    it do
      expect(instance.run).to eq(data)
    end
  end
end
