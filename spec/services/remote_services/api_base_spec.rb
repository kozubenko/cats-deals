require 'rails_helper'

RSpec.describe RemoteServices::ApiBase do
  let(:factory_class_name) { 'AbstractSourceFactory' }
  let(:factory) { double factory_class_name }

  let(:instance) { described_class.new(factory) }
  let(:source_instance) { instance_double 'ApiSources::BaseSource' }

  let(:response) { instance_double 'Typhoeus::Response' }

  it_behaves_like 'fetch api'

  describe '#run' do
    subject { instance.send(:run) }

    it 'works correct' do
      expect(instance).to receive(:generate_requests)
      expect(instance.hydra).to receive(:run)

      subject
    end
  end

  describe '#add_to_storage' do
    subject { instance.send(:add_to_storage, nil) }

    it 'works correct' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end
end
