require "rails_helper"

RSpec.describe RemoteServices::ApiBase do
  include_examples "fetch api"

  describe "#add_to_storage" do
    subject { instance.send(:add_to_storage, nil) }

    it "works correct" do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end
end
