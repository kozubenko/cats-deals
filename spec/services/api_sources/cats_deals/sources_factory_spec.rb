require 'rails_helper'

RSpec.describe ApiSources::CatsDeals::SourcesFactory do
  let(:instance) { described_class.new }

  describe '#happy_cats' do
    subject { instance.send(:happy_cats) }

    it 'return happy cats participant' do
      participant = instance_double '::CatsDeals::Participants::HappyCats'
      expect(::ApiSources::CatsDeals::HappyCats).to receive(:new).and_return(participant)

      expect(subject).to eq(participant)
    end
  end

  describe '#unlimited_cats' do
    subject { instance.send(:unlimited_cats) }

    it 'return happy cats participant' do
      participant = instance_double '::CatsDeals::Participants::UnlimitedCats'
      expect(::ApiSources::CatsDeals::UnlimitedCats).to receive(:new).and_return(participant)

      expect(subject).to eq(participant)
    end
  end
end
