require 'rails_helper'

RSpec.describe ApiSources::BaseSource do
  let(:instance) { described_class.new }

  it_behaves_like 'instance interface method', %i[handle_response options fetch_url]
end
