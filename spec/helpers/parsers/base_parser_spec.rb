require 'rails_helper'

RSpec.describe Parsers::BaseParser do
  let(:instance) { described_class.new('') }

  it_behaves_like 'instance interface method', :run
end
