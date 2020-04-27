require 'rails_helper'

RSpec.describe ApiSources::CatsDeals::SourcesFactory do
  let(:instance) { described_class.new }

  shared_examples 'source instance' do |methods|
    Array.wrap(methods).each do |method|
      describe "##{method}" do
        it "return #{method} source" do
          source_class_name = "ApiSources::CatsDeals::#{method.camelize}"
          source = instance_double source_class_name

          expect(source_class_name.constantize).to receive(:new).and_return(source)
          expect(instance.send(method)).to eq(source)
        end
      end
    end
  end

  it_behaves_like 'source instance', %w[unlimited_cats happy_cats]
end
