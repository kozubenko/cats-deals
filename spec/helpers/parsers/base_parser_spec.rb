require "rails_helper"

RSpec.describe Parsers::BaseParser do
  let(:instance) { described_class.new("") }

  describe "#run" do
    it do
      expect { instance.run }.to raise_error(NotImplementedError)
    end
  end
end
