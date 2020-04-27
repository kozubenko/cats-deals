RSpec.shared_examples 'instance interface method' do |method_names, *args|
  Array.wrap(method_names).each do |method_name|
    describe "##{method_name}" do
      subject { instance.send(method_name, *args) }

      it 'raise error' do
        expect { subject }.to raise_error(
          NotImplementedError,
          "#{described_class} has not implemented method '#{method_name}'"
        )
      end
    end
  end
end
