require "rails_helper"

RSpec.describe CatsDeals::Participants::ParticipantsFactory do
  let(:instance) { described_class.new }

  describe "#happy_cats" do
    subject { instance.send(:happy_cats) }

    it "return happy cats participant" do
      participant = instance_double "::CatsDeals::Participants::HappyCats"
      expect(::CatsDeals::Participants::HappyCats).to receive(:new).and_return(participant)
      expect(subject).to eq(participant)
    end
  end

  describe "#unlimited_cats" do
    subject { instance.send(:unlimited_cats) }

    it "return happy cats participant" do
      participant = instance_double "::CatsDeals::Participants::UnlimitedCats"
      expect(::CatsDeals::Participants::UnlimitedCats).to receive(:new).and_return(participant)
      expect(subject).to eq(participant)
    end
  end
end
