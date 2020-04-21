require "rails_helper"

RSpec.describe RemoteServices::FetchCollectionsApi do
  include_examples "fetch api"

  describe "#add_to_storage" do
    response = [1, 2, 3]
    subject { instance.send(:add_to_storage, response) }

    it "works correct" do
      expect(subject).to eq(response)
    end
  end
end
