RSpec.shared_examples "fetch api" do
  let(:factory_class_name) { "AbstractSourceFactory" }
  let(:factory) { double factory_class_name }

  let(:instance) { described_class.new(factory) }
  let(:source_instance) { instance_double "ApiSources::BaseSource" }

  let(:response) { instance_double "Typhoeus::Response" }

  describe "#fetch" do
    subject { instance.send(:fetch) }

    it "works correct" do
      expect(instance).to receive(:generate_requests)
      expect(instance.hydra).to receive(:run)

      subject
    end
  end

  describe "#generate_requests" do
    subject { instance.send(:generate_requests) }

    it "works correct" do
      expect(instance).to receive(:data_sources).once.and_return([source_instance])
      expect(instance).to receive(:build_request).once.with(source_instance)
      subject
    end
  end

  describe "#build_request" do
    subject { instance.send(:build_request, source_instance) }

    it "works correct" do
      request = instance_double "Typhoeus::Request"
      url = FFaker::Internet.uri("https")
      options = {}

      expect(source_instance).to receive(:fetch_url).once.and_return(url)
      expect(source_instance).to receive(:options).once.and_return(options)

      expect(Typhoeus::Request).to receive(:new).with(url, options).and_return(request)
      expect(instance.hydra).to receive(:queue).with(request)

      expect(request).to receive(:on_complete).and_yield(response)
      expect(instance).to receive(:process_response).with(response, source_instance)

      subject
    end
  end

  describe "#data_sources" do
    subject { instance.send(:data_sources) }

    it "works correct" do
      factory_instance = instance_double factory_class_name
      allow(factory).to receive(:new).and_return(factory_instance)
      allow(factory).to receive(:instance_methods).with(false).and_return([:method1])

      expect(factory_instance).to receive(:public_send).with(:method1).once.and_return(source_instance)

      expect(subject).to eq([source_instance])
    end
  end

  describe "#process_response" do
    subject { instance.send(:process_response, response, source_instance) }

    it "works correct" do
      parsed_response_mock = "parsed_response_mock"
      expect(response).to receive(:success?).and_return(true)
      expect(source_instance).to receive(:handle_response).with(response).and_return(parsed_response_mock)
      expect(instance).to receive(:add_to_storage).with(parsed_response_mock)

      subject
    end

    context "response timed out" do
      it "works correct" do
        expect(response).to receive(:success?).and_return(false)
        expect(response).to receive(:timed_out?).and_return(true)
        expect(instance).not_to receive(:add_to_storage)

        subject
      end
    end

    context "response response code is 0" do
      it "works correct" do
        expect(response).to receive(:success?).and_return(false)
        expect(response).to receive(:timed_out?).and_return(false)

        expect(response).to receive(:code).and_return(0)
        expect(response).to receive(:return_message)
        expect(instance).not_to receive(:add_to_storage)

        subject
      end
    end
  end
end
