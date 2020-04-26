require 'rails_helper'

RSpec.describe ApiSources::CatsDeals::SourcesFactory do
  shared_examples 'source instance' do |method, source_class_name|
    let(:instance) { described_class.new }
    let(:source) { instance_double source_class_name }

    it 'return source' do
      expect(source_class_name.constantize).to receive(:new).and_return(source)

      expect(instance.send(method)).to eq(source)
    end
  end

  describe '#unlimited_cats' do
    it_behaves_like 'source instance', :unlimited_cats, 'ApiSources::CatsDeals::UnlimitedCats'
  end

  describe '#happy_cats' do
    it_behaves_like 'source instance', :happy_cats, 'ApiSources::CatsDeals::HappyCats'
  end
end
