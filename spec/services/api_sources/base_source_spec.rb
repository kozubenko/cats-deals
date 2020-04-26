require 'rails_helper'

RSpec.describe ApiSources::BaseSource do
  let(:instance) { described_class.new }

  describe '#handle_response' do
    subject { instance.send(:handle_response) }

    it 'works correct' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe '#options' do
    subject { instance.send(:options) }

    it 'works correct' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe '#fetch_url' do
    subject { instance.send(:fetch_url) }

    it 'works correct' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end
end
